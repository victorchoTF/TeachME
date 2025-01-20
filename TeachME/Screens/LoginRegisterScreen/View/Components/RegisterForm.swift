//
//  Form.swift
//  TeachME
//
//  Created by TumbaDev on 20.01.25.
//

import SwiftUI

struct RegisterForm: View {
    @State var registerFields: RegisterFields
    
    var body: some View {
        Form {
            accountDetails
            
            personalDetails
            
            roleDetails
        }
        .scrollContentBackground(.hidden)
    }
    
    private var accountDetails: some View {
        Section("Account Details") {
            TextField("Email", text: $registerFields.email)
                .textFieldStyle(.roundedBorder)
                .disableAutocorrection(true)
            TextField("Password", text: $registerFields.password)
                .textFieldStyle(.roundedBorder)
                .disableAutocorrection(true)
        }
    }
    
    private var personalDetails: some View {
        Section("Personal Details") {
            TextField("Name", text: $registerFields.firstName)
                .textFieldStyle(.roundedBorder)
                .disableAutocorrection(true)
            TextField("Last Name", text: $registerFields.lastName)
                .textFieldStyle(.roundedBorder)
                .disableAutocorrection(true)
        }
    }
    
    private var roleDetails: some View {
        Section("Role") {
            Picker("Role", selection: $registerFields.roleType) {
                Text("Student").tag(Role.student)
                Text("Teacher").tag(Role.teacher)
            }
            .pickerStyle(.segmented)
        }
    }
}

#Preview {
    RegisterForm(registerFields: RegisterFields())
}
