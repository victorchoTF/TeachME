//
//  UserMapper.swift
//  TeachME
//
//  Created by TumbaDev on 8.03.25.
//

import Foundation
import SwiftUI

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
    
    func lessonBodyDTOToModel(_ data: UserLessonBodyDTO) -> UserLessonBodyModel {
        UserLessonBodyModel(
            id: data.id,
            firstName: data.firstName,
            lastName: data.lastName,
            profilePicture: data.profilePicture
        )
    }
    
    func lessonBodyModelToDTO(_ model: UserLessonBodyModel) -> UserLessonBodyDTO {
        UserLessonBodyDTO(
            id: model.id,
            firstName: model.firstName,
            lastName: model.lastName,
            profilePicture: model.profilePicture
        )
    }
    
    func credentialBodyDTOToModel(_ data: UserCredentialsBodyDTO) -> UserCredentialsBodyModel {
        UserCredentialsBodyModel(email: data.email, password: data.password)
    }
    
    func credentialBodyModelToDTO(_ model: UserCredentialsBodyModel) -> UserCredentialsBodyDTO {
        UserCredentialsBodyDTO(email: model.email, password: model.password)
    }
    
    func registerBodyDTOToModel(_ data: UserRegisterBodyDTO) -> UserRegisterBodyModel {
        UserRegisterBodyModel(
            email: data.email,
            password: data.password,
            firstName: data.firstName,
            lastName: data.lastName,
            roleId: data.roleId //TODO: Appoint via the Role enum
        )
    }
    
    func registerBodyModelToData(_ model: UserRegisterBodyModel) -> UserRegisterBodyDTO {
        UserRegisterBodyDTO(
            email: model.email,
            password: model.password,
            firstName: model.firstName,
            lastName: model.lastName,
            roleId: model.roleId //TODO: Role enum -> roleID
        )
    }
    
    func modelToItem(_ model: UserModel) -> UserItem {
        return UserItem(
            name: "\(model.firstName) \(model.lastName)",
            profilePicture: Image(
                systemName: "person.crop.circle"
            ).dataToImage(model.userDetail?.profilePicture),
            email: model.email,
            phoneNumber: model.userDetail?.phoneNumber ?? "",
            bio: model.userDetail?.bio ?? ""
        )
    }
}
