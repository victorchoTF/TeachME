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
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            guard let imageSelection = imageSelection, let user = userItem else {
                return
            }
            
            Task {
                router?.user = try await updateUserByBodyModel(
                    user: mapper.itemWithProfilePictureToBodyModel(
                        user,
                        profilePicture: try await loadImage(from: imageSelection)
                    )
                ) ?? user
            }
        }
    }
    
    private let userRepository: UserRepository
    private let mapper: UserMapper
    private let imageFormatter: ImageFormatter
    
    private weak var router: ProfileRouter?
    
    init(
        router: ProfileRouter?,
        userRepository: UserRepository,
        mapper: UserMapper,
        imageFormatter: ImageFormatter
    ) {
        self.router = router
        self.userRepository = userRepository
        self.mapper = mapper
        self.imageFormatter = imageFormatter
    }
    
    var editButtonText: String {
        "Edit"
    }
    
    func openEditProfile() {
        guard let user = userItem else {
            return
        }
        
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
            guard let user = try await updateUser(user: userItem) else {
                return
            }
            
            self.router?.user = user
            
            editProfileFormViewModel = nil
        }
    }
    
    var userItem: UserItem? {
        router?.user
    }
}

private extension ProfileScreenViewModel {
    func updateUser(user: UserItemBody) async throws -> UserItem? {
        guard let userItem = userItem else {
            return nil
        }
        
        let userModelBody = mapper.itemBodyToBodyModel(user, userId: userItem.id)
        
        return try await updateUserByBodyModel(user: userModelBody)
    }
    
    func updateUserByBodyModel(user: UserBodyModel) async throws -> UserItem? {
        guard let userItem = userItem else {
            return nil
        }
        
        try await userRepository.update(user, id: userItem.id)
        
        return try await mapper.modelToItem(userRepository.getById(userItem.id))
    }
    
    func loadImage(from item: PhotosPickerItem?) async throws -> Data? {
        guard let item else { return nil }
        
        let data = try await item.loadTransferable(type: Data.self)

        guard let imageData = data, let image = UIImage(data: imageData) else { return nil }

        let resizedImage = imageFormatter.resizeImage(image, maxWidth: 256, maxHeight: 256)
        
        let finalImage = imageFormatter.cropImageToSquare(resizedImage)
            
        return imageFormatter.compressImage(finalImage)
    }
}
