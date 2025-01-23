//
//  FormInputs.swift
//  vdim
//
//  Created by Alikia2x on 2025/1/18.
//

import SwiftUI

enum LoginFormInputType {
    case username
    case email
    case TFACode
}

struct LoginFormBasicInput: View {
    @EnvironmentObject var userAuth: UserAuthState
    let type: LoginFormInputType
    let title: String
    let prompt: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .padding(.leading, 24)
            switch type {
            case .email:
                TextField(
                    "", text: $userAuth.email,
                    prompt: Text(prompt).foregroundColor(
                        Color("LoginFormTextFieldPlaceholder"))
                )
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 8).fill(
                        Color(.loginFormTextFieldBackground))
                )
                .padding([.leading, .trailing], 24)
                .autocorrectionDisabled()
            case .username:
                TextField(
                    "", text: $userAuth.username,
                    prompt: Text(prompt).foregroundColor(
                        Color("LoginFormTextFieldPlaceholder"))
                )
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 8).fill(
                        Color(.loginFormTextFieldBackground))
                )
                .padding([.leading, .trailing], 24)
                .autocorrectionDisabled()
            default:
                TextField(
                    "", text: $userAuth.username,
                    prompt: Text(prompt).foregroundColor(
                        Color("LoginFormTextFieldPlaceholder"))
                )
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 8).fill(
                        Color(.loginFormTextFieldBackground))
                )
                .padding([.leading, .trailing], 24)
                .autocorrectionDisabled()
            }
        }

    }
}


struct LoginFormPasswordInput: View {
    @EnvironmentObject var userAuth: UserAuthState
    let register: Bool
    var body: some View {
        Text("密码")
            .padding(.leading, 24)
            .padding(.top, 16)
        PasswordInput(password: $userAuth.password, showStrength: register)
    }
}

