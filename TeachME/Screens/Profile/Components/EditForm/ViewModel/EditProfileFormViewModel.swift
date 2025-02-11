//
//  EditProfileFormViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 9.02.25.
//

import Foundation

final class EditProfileFormViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var phoneNumber: String = ""
    @Published var bio: String = ""
    
    @Published var userItem: UserItem?
    
    let onSubmit: () -> ()
    
    init(userItem: UserItem?, onSubmit: @escaping () -> ()) {
        self.userItem = userItem
        self.onSubmit = onSubmit
        
        if let user = userItem {
            self.email = user.email
            self.firstName = String(user.name.split(separator: " ")[0])
            self.lastName = String(user.name.split(separator: " ")[1])
            self.phoneNumber = user.phoneNumber
            self.bio = user.bio
        }
    }
    
    var formTitle: String {
        "Edit your TeachME profile"
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
    
    var buttonText: String {
        "Edit"
    }
    
    func userFromForm(user: UserItem) -> UserItem {
        return UserItem(
            name: "\(firstName) \(lastName)",
            email: email,
            phoneNumber: phoneNumber,
            bio: bio
        )
    }
}
