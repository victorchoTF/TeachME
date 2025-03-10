//
//  UserMapper.swift
//  TeachME
//
//  Created by TumbaDev on 8.03.25.
//

import Foundation

struct UserMapper: Mapper {
    let userDetailMapper: UserDetailMapper
    let roleMapper: RoleMapper
    
    func dtoToModel(_ data: UserDTO) -> UserModel {
        let userDetailModel: UserDetailModel?
        
        if let userDetail = data.userDetail {
            userDetailModel = userDetailMapper.dtoToModel(userDetail)
        } else {
            userDetailModel = nil
        }
        
        return UserModel(
            id: data.id,
            email: data.email,
            firstName: data.firstName,
            lastName: data.lastName,
            userDetail: userDetailModel,
            role: roleMapper.dtoToModel(data.role)
        )
    }
    
    func modelToDTO(_ model: UserModel) -> UserDTO {
        let userDetailData: UserDetailDTO?
        
        if let userDetail = model.userDetail {
            userDetailData = userDetailMapper.modelToDTO(userDetail)
        } else {
            userDetailData = nil
        }
        
        return UserDTO(
            id: model.id,
            email: model.email,
            firstName: model.firstName,
            lastName: model.lastName,
            userDetail: userDetailData,
            role: roleMapper.modelToDTO(model.role)
        )
    }
    
    func lessonBodyDataToModel(_ data: UserLessonBodyDTO) -> UserLessonBodyModel {
        UserLessonBodyModel(id: data.id, firstName: data.firstName, lastName: data.lastName)
    }
    
    func lessonBodyModelToData(_ model: UserLessonBodyModel) -> UserLessonBodyDTO {
        UserLessonBodyDTO(id: model.id, firstName: model.firstName, lastName: model.lastName)
    }
}
