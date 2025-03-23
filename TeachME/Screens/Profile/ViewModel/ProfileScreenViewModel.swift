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
    
    private weak var router: ProfileRouter?
    
    init(router: ProfileRouter?, userRepository: UserRepository, mapper: UserMapper) {
        self.router = router
        self.userRepository = userRepository
        self.mapper = mapper
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
        
        // TODO: userItem is in the router, so the fetch is not needed
        let profilePicture = try await userRepository.getById(
            userItem.id
        ).userDetail?.profilePicture
        
        let userModelBody = mapper.itemBodyToBodyModel(
            user,
            userId: userItem.id,
            profilePicture: profilePicture
        )
        
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
        
        let resizedImage = resizeImage(image, maxWidth: 256, maxHeight: 256)
            
        return compressImage(resizedImage)
    }
    
    func compressImage(
        _ image: UIImage,
        maxFileSize: Int = 1_000_000,
        minQuality: CGFloat = 0.1
    ) -> Data? {
        var compression: CGFloat = 0.8
        var imageData = image.jpegData(compressionQuality: compression)

        while let data = imageData, data.count > maxFileSize, compression > minQuality {
            compression -= 0.1
            imageData = image.jpegData(compressionQuality: compression)
        }
        
        return imageData
    }
    
    func resizeImage(_ image: UIImage, maxWidth: CGFloat, maxHeight: CGFloat) -> UIImage {
        let aspectRatio = image.size.width / image.size.height
        
        let newSize: CGSize
        if aspectRatio > 1 {
            newSize = CGSize(width: maxWidth, height: maxWidth / aspectRatio)
        } else {
            newSize = CGSize(width: maxHeight * aspectRatio, height: maxHeight)
        }

        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        let renderer = UIGraphicsImageRenderer(size: newSize, format: format)
        
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }

}
