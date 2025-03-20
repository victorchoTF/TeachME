//
//  ProfileScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 8.02.25.
//

import Foundation
import SwiftUI

final class ProfileScreenViewModel: ObservableObject {
    @Published var userItem: UserItem?
    @Published var editProfileFormViewModel: EditProfileFormViewModel?
    
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
        guard let user = router?.user else {
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
}

private extension ProfileScreenViewModel {
    func updateUser(user: UserItemBody) async throws -> UserItem? {
        guard let userItem = router?.user else {
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
        
        try await userRepository.update(userModelBody, id: userItem.id)
        
        return try await mapper.modelToItem(userRepository.getById(userItem.id))
    }
}
