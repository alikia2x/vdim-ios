//
//  LoginForm.swift
//  vdim
//
//  Created by Alikia2x on 2025/1/18.
//

import SwiftUI

struct RegisterStep1: View {
    @EnvironmentObject var userAuth: UserAuthState
    
    func verify() {
        
    }

    var body: some View {
        VStack(alignment: .leading) {
            LoginFormBasicInput(
                type: .username,
                title: "用户名",
                prompt: "取一个好听的名字吧…"
            )

            LoginFormPasswordInput(register: true)

            Spacer()

            Button(action: {
                userAuth.action += 1
            }) {
                Text("下一步 (1/4)")
                    .font(.title3)
                    .frame(maxWidth: .infinity, maxHeight: 28)
            }
            .padding(.bottom, 24)
            .padding([.leading, .trailing], 24)
            .buttonStyle(.borderedProminent)
        }
    }
}

struct RegisterStep2: View {
    @EnvironmentObject var userAuth: UserAuthState

    var body: some View {
        VStack(alignment: .leading) {
            LoginFormBasicInput(type: .email, title: "邮箱", prompt: "输入你的邮箱")

            LoginFormBasicInput(type: .TFACode, title: "验证码", prompt: "输入验证码")
                .padding(.top, 16)

            Spacer()

            Button(action: {
                userAuth.action += 1
            }) {
                Text("注册")
                    .font(.title3)
                    .frame(maxWidth: .infinity, maxHeight: 28)
            }
            .padding(.bottom, 24)
            .padding([.leading, .trailing], 24)
            .buttonStyle(.borderedProminent)
            .disabled(true)
        }
    }
}

struct RegisterForm_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(UserAuthState(action: 2))
    }
}
