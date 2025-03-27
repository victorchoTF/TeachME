//
//  EditProfileFormViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 9.02.25.
//

import Foundation

enum EditProfileAlertType {
    case firstName
    case lastName
    case email
}

final class EditProfileFormViewModel: ObservableObject, Identifiable {
    @Published var alertItem: AlertItem? = nil
    @Published var alertType: EditProfileAlertType? = nil
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
            alertType = .firstName
            alertItem = AlertItem(message: alertMessage)
            
            return String(userItem.name.split(separator: " ").first ?? "-") + " "
        }
        
        return firstName
    }
    
    func checkLastName() -> String {
        if lastName.isEmpty {
            alertType = .lastName
            alertItem = AlertItem(message: alertMessage)
            
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
        alertType = .email
        alertItem = AlertItem(message: alertMessage)
    }
    
    var alertMessage: String {
        switch alertType {
        case .firstName:
            "You first name was not updated correctly!\nPlease try again!"
        case .lastName:
            "You last name was not updated correctly!\nPlease try again!"
        case .email:
            "Your email was not updated correctly!\nPlease try again!"
        default:
            "A field was not updated correctly!\nPlease try again!"
        }
    }
}
