//
//  EditProfileFormViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 9.02.25.
//

import Foundation

final class EditProfileFormViewModel: ObservableObject, Identifiable {
    @Published var alertItem: AlertItem? = nil
    @Published var email: String
    @Published var firstName: String
    @Published var lastName: String
    @Published var phoneNumber: String
    @Published var bio: String
    
    let userItem: UserItem
    
    private let updateUser: (UserItemBody) -> ()
    let onCancel: () -> ()
    
    private let emailValidator: EmailValidator
    
    init(
        userItem: UserItem,
        emailValidator: EmailValidator,
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
        
        self.emailValidator = emailValidator
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
        
        if alertItem == nil {
            updateUser(user)
        }
    }
}

private extension EditProfileFormViewModel {
    func checkFirstName() -> String {
        if firstName.isEmpty {
            alertItem = AlertItem(alertType: .firstName)
            
            return String(userItem.name.split(separator: " ").first ?? "-") + " "
        }
        
        return firstName
    }
    
    func checkLastName() -> String {
        if lastName.isEmpty {
            alertItem = AlertItem(alertType: .lastName)
            
            return String(userItem.name.split(separator: " ").last ?? "-")
        }
        
        return lastName
    }
    
    func checkEmail() -> String {
        if email.isEmpty {
            setEmailInvalid()
            
            return userItem.email
        }
        
        guard emailValidator.isValid(email: email) else {
            setEmailInvalid()
            
            return userItem.email
        }
        
        return email
    }
    
    func setEmailInvalid() {
        alertItem = AlertItem(alertType: .email)
    }
}
