//
//  UserDetailMapper.swift
//  TeachME
//
//  Created by TumbaDev on 8.03.25.
//

import Foundation

struct UserDetailMapper: Mapper {
    func dataToModel(_ data: UserDetailDTO) -> UserDetailModel {
        UserDetailModel(
            id: data.id,
            bio: data.bio,
            profilePicture: data.profilePicture,
            phoneNumber: data.phoneNumber
        )
    }
    
    func modelToData(_ model: UserDetailModel) -> UserDetailDTO {
        UserDetailDTO(
            id: model.id,
            bio: model.bio,
            profilePicture: model.profilePicture,
            phoneNumber: model.phoneNumber
        )
    }
}
