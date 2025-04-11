//
//  ProfileScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 8.02.25.
//

import SwiftUI
import PhotosUI

@MainActor final class ProfileScreenViewModel: ObservableObject {
    @Published var editProfileFormViewModel: EditProfileFormViewModel?
    @Published var user: UserItem
    
    @Published var alertItem: AlertItem? = nil
    
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setProfilePicture()
        }
    }
    
    private let userRepository: UserRepository
    private let mapper: UserMapper
    private let imageFormatter: ImageFormatter
    private var profilePicture: Data? = nil {
        didSet {
            alertItem = AlertItem(
                alertType: .confirmImage,
                primaryAction: AlertAction(
                    title: imageAlertAccept,
                    action: updateProfilePicture
                ),
                secondaryAction: .defaultCancelation()
            )
        }
    }
    
    private let emailValidator: EmailValidator
    
    private weak var router: ProfileRouter?
    
    let logOut: () -> ()
    
    init(
        router: ProfileRouter?,
        user: UserItem,
        userRepository: UserRepository,
        mapper: UserMapper,
        imageFormatter: ImageFormatter,
        emailValidator: EmailValidator,
        logOut: @escaping () -> ()
    ) {
        self.router = router
        self.userRepository = userRepository
        self.mapper = mapper
        self.imageFormatter = imageFormatter
        self.user = user
        self.emailValidator = emailValidator
        self.logOut = logOut
    }
    
    var editButtonText: String {
        "Edit"
    }
    
    var editButtonIcon: String {
        "square.and.pencil"
    }
    
    var logOutButtonText: String {
        "Log Out"
    }
    
    var logOutButtonIcon: String {
        "rectangle.portrait.and.arrow.right"
    }
    
    var settingsIcon: String {
        "gearshape"
    }
    
    func openEditProfile() {
        editProfileFormViewModel = EditProfileFormViewModel(
            userItem: user,
            emailValidator: emailValidator,
            onCancel: { [weak self] in
            self?.editProfileFormViewModel = nil
        }) { [weak self] user in
            self?.updateProfile(userItem: user)
        }
    }

    func updateProfile(userItem: UserItemBody) {
        Task {
            self.user = try await updateUser(user: userItem)
            
            editProfileFormViewModel = nil
        }
    }
}

private extension ProfileScreenViewModel {
    func updateProfilePicture() {
        Task {
            user = try await updateUserByBodyModel(user: userBodyModelWithImage())
        }
    }
    
    var imageAlertAccept: String {
        "Yes"
    }
    
    func updateUser(user: UserItemBody) async throws -> UserItem {
        let userModelBody = mapper.itemBodyToBodyModel(user, userId: self.user.id)
        
        return try await updateUserByBodyModel(user: userModelBody)
    }
    
    func updateUserByBodyModel(user: UserBodyModel) async throws -> UserItem {
        try await userRepository.update(user, id: self.user.id)
        
        return try await mapper.modelToItem(userRepository.getById(self.user.id))
    }
    
    func userBodyModelWithImage() async throws -> UserBodyModel {
        mapper.itemWithProfilePictureToBodyModel(
            user,
            profilePicture: profilePicture
        )
    }
    
    func setProfilePicture() {
        guard let imageSelection = imageSelection else {
            return
        }
        
        Task {
            profilePicture = try await imageFormatter.loadImage(from: imageSelection)
        }
    }
}
