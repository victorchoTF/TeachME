//
//  ProfileScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 8.02.25.
//

import Foundation
import SwiftUI

final class ProfileScreenViewModel: ObservableObject {
    @Published var userItem: UserItem
    @Published var editProfileFormViewModel: EditProfileFormViewModel?
    
    private let repository: UserRepository
    private let mapper: UserMapper
    
    init(userItem: UserItem, repository: UserRepository, mapper: UserMapper) {
        self.userItem = userItem
        self.repository = repository
        self.mapper = mapper
    }
    
    var editButtonText: String {
        "Edit"
    }
    
    func openEditProfile() {
        editProfileFormViewModel = EditProfileFormViewModel(
            userItem: userItem,
            onCancel: { [weak self] in
            self?.editProfileFormViewModel = nil
        }) { [weak self] user in
            self?.updateProfile(userItem: user)
        }
    }

    func updateProfile(userItem: UserItemBody) {
        Task {
            self.userItem = try await updateUser(user: userItem)
            
            editProfileFormViewModel = nil
        }
    }
}

private extension ProfileScreenViewModel {
    func updateUser(user: UserItemBody) async throws -> UserItem {
        let profilePicture = try await repository.getById(userItem.id).userDetail?.profilePicture
        
        let userModelBody = mapper.itemBodyToBodyModel(
            user,
            userId: userItem.id,
            profilePicture: profilePicture
        )
        
        try await repository.update(userModelBody, id: userItem.id)
        
        return try await mapper.modelToItem(repository.getById(userItem.id))
    }
}
