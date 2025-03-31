//
//  ProfileScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 8.02.25.
//

import Foundation
import SwiftUI
import PhotosUI

final class ProfileScreenViewModel: ObservableObject {
    @Published var editProfileFormViewModel: EditProfileFormViewModel?
    @Published var user: UserItem
    
    @Published var updateImageAlert: Bool = false
    
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
            updateImageAlert = true
        }
    }
    
    
    private weak var router: ProfileRouter?
    
    init(
        router: ProfileRouter?,
        user: UserItem,
        userRepository: UserRepository,
        mapper: UserMapper,
        imageFormatter: ImageFormatter
    ) {
        self.router = router
        self.userRepository = userRepository
        self.mapper = mapper
        self.imageFormatter = imageFormatter
        self.user = user
    }
    
    var editButtonText: String {
        "Edit"
    }
    
    func openEditProfile() {
        editProfileFormViewModel = EditProfileFormViewModel(
            userItem: user,
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
    
    func updateProfilePicture() {
        Task {
            user = try await updateUserByBodyModel(user: userBodyModelWithImage())
        }
    }
    
    func cancelProfilePictureUpdate() {
        updateImageAlert = false
    }
    
    var imageAlertMessage: String {
        "Are you sure this is your picture?"
    }
    
    var imageAlertAccept: String {
        "Yes"
    }
    
    var imageAlertCancel: String {
        "Cancel"
    }
}

private extension ProfileScreenViewModel {
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
