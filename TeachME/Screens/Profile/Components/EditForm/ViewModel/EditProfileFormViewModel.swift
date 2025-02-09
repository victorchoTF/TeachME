//
//  EditProfileFormViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 9.02.25.
//

import Foundation

final class EditProfileFormViewModel: ObservableObject {
    @Published var email: String
    @Published var firstName: String
    @Published var lastName: String
    @Published var phoneNumber: String
    @Published var bio: String
    
    init(email: String, firstName: String, lastName: String, phoneNumber: String, bio: String) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.bio = bio
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
    
    func onSubmit(user: UserItem) -> UserItem {
        print("Submitted")
        
        return UserItem(
            name: "\(firstName) \(lastName)",
            email: email,
            phoneNumber: phoneNumber,
            bio: bio
        )
    }
}
