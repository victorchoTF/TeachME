//
//  EditProfileFormViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 9.02.25.
//

import Foundation

final class EditProfileFormViewModel: ObservableObject, Identifiable {
    @Published var email: String
    @Published var firstName: String
    @Published var lastName: String
    @Published var phoneNumber: String
    @Published var bio: String
    
    let userItem: UserItem
    
    private let updateUser: (UserItemBody) -> ()
    let onCancel: () -> ()
    
    init(
        userItem: UserItem,
        onCancel: @escaping () -> (),
        updateUser: @escaping (UserItemBody) -> ()
    ) {
        self.onCancel = onCancel
        self.updateUser = updateUser
        self.userItem = userItem
        
        self.email = userItem.email
        self.firstName = String(userItem.name.split(separator: " ")[0])
        self.lastName = String(userItem.name.split(separator: " ")[1])
        self.phoneNumber = userItem.phoneNumber
        self.bio = userItem.bio
    }
    
    var formTitle: String {
        "Edit your profile"
    }
    
    var emailPlaceholder: String {
        "Email"
    }
    
    var namePlaceholder: String {
        "Name"
    }
    
    var lastNamePlaceholder: String {
        "Last Name"
    }
    
    var phoneNumberPlaceholder: String {
        "Phone number"
    }
    
    var bioPlaceholder: String {
        "Tell us more about yourself"
    }
    
    var cancelButtonText: String {
        "Cancel"
    }
    
    var doneButtonText: String {
        "Done"
    }
    
    var shouldShowBioPlaceholder: Bool {
        bio.isEmpty
    }
    
    func onSubmit() {
        let user = UserItemBody(
            firstName: checkFirstName(),
            lastName: checkLastName(),
            email: checkEmail(),
            phoneNumber: phoneNumber,
            bio: bio
        )
        
        updateUser(user)
    }
}

private extension EditProfileFormViewModel {
    func checkFirstName() -> String {
        if firstName.isEmpty {
            return String(userItem.name.split(separator: " ")[0]) + " "
        }
        
        return firstName
    }
    
    func checkLastName() -> String {
        if lastName.isEmpty {
            return String(userItem.name.split(separator: " ")[0])
        }
        return lastName
    }
    
    func checkEmail() -> String {
        if email.isEmpty {
            return userItem.email
        }
        
        return email
    }
}
