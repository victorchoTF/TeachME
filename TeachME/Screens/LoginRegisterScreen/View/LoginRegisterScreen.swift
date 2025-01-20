//
//  SwiftUIView.swift
//  TeachME
//
//  Created by TumbaDev on 20.01.25.
//

import SwiftUI

struct LoginRegisterScreen: View {
    @State var registerFields: RegisterFields
    var body: some View {
        RegisterForm(registerFields: registerFields)
    }
}

#Preview {
    LoginRegisterScreen(registerFields: RegisterFields())
}
