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
    
    func modelToLessonBodyModel(_ model: UserModel) -> UserLessonBodyModel {
        UserLessonBodyModel(
            id: model.id,
            firstName: model.firstName,
            lastName: model.lastName,
            profilePicture: model.userDetail?.profilePicture
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
            roleId: data.roleId
        )
    }
    
    func registerBodyModelToDTO(_ model: UserRegisterBodyModel) -> UserRegisterBodyDTO {
        UserRegisterBodyDTO(
            email: model.email,
            password: model.password,
            firstName: model.firstName,
            lastName: model.lastName,
            roleId: model.roleId
        )
    }
    
    func modelToItem(_ model: UserModel, roles: Roles) -> UserItem {
        return UserItem(
            id: model.id,
            name: "\(model.firstName) \(model.lastName)",
            profilePicture: Image(
                data: model.userDetail?.profilePicture,
                fallbackImageName: "person.crop.circle"
            ),
            email: model.email,
            phoneNumber: model.userDetail?.phoneNumber ?? "",
            bio: model.userDetail?.bio ?? "",
            role: roles.toRole(roleModel: model.role)
        )
    }
    
    func itemBodyToBodyModel(
        _ item: UserItemBody,
        userId: UUID,
        profilePicture: Data? = nil
    ) -> UserBodyModel {
        return UserBodyModel(
            email: item.email,
            firstName: item.firstName,
            lastName: item.lastName,
            userDetails: UserDetailBodyModel(
                userId: userId,
                bio: item.bio != "" ? item.bio : nil,
                profilePicture: profilePicture,
                phoneNumber: item.phoneNumber != "" ? item.phoneNumber : nil
            )
        )
    }
    
    func bodyModelToBodyDTO(_ model: UserBodyModel, userId: UUID) -> UserBodyDTO {
        UserBodyDTO(
            email: model.email,
            firstName: model.firstName,
            lastName: model.lastName,
            userDetails: UserDetailBodyDTO(
                userId: userId,
                bio: model.userDetails?.bio,
                profilePicture: model.userDetails?.profilePicture,
                phoneNumber: model.userDetails?.phoneNumber
            )
        )
    }
    
    func itemToBodyLessonModel(_ user: UserItem) -> UserLessonBodyModel {
        UserLessonBodyModel(
            id: user.id,
            firstName: String(user.name.split(separator: " ").first ?? "-"),
            lastName: String(user.name.split(separator: " ").last ?? "-"),
            profilePicture: nil
        )
    }
    
    func itemWithProfilePictureToBodyModel(
        _ user: UserItem,
        profilePicture: Data?
    ) -> UserBodyModel {
        itemBodyToBodyModel(
            UserItemBody(
                firstName: String(user.name.split(separator: " ").first ?? "-"),
                lastName: String(user.name.split(separator: " ").last ?? "-"),
                email: user.email,
                phoneNumber: user.phoneNumber,
                bio: user.bio
            ),
            userId: user.id,
            profilePicture: profilePicture
        )
        
    }
}
