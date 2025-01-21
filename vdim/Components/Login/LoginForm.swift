//
//  LoginForm.swift
//  vdim
//
//  Created by Alikia2x on 2025/1/18.
//

import SwiftUI

struct LoginForm: View {
   @EnvironmentObject var userAuth: UserAuthState

   var body: some View {
       VStack(alignment: .leading) {
           Text("用户名")
               .padding(.leading, 24)
           TextField(
               "", text: $userAuth.username,
               prompt: Text("输入用户名").foregroundColor(
                   Color(.loginFormTextFieldPlaceholder))
           )
           .padding(12)
           .background(
               RoundedRectangle(cornerRadius: 8).fill(
                   Color(.loginFormTextFieldBackground))
           )
           .padding([.leading, .trailing], 24)
           .autocorrectionDisabled()

           Text("密码")
               .padding(.leading, 24)
               .padding(.top, 16)
           PasswordInput(password: $userAuth.password, showStrength: false)

           Spacer()

           Button(action: {
               // 没有逻辑
           }) {
               Text("登入")
                   .font(.title3)
                   .frame(maxWidth: .infinity, maxHeight: 28)
           }
           .padding(.bottom, 24)
           .padding([.leading, .trailing], 24)
           .buttonStyle(.borderedProminent)
       }
       .padding(.top, 8)
   }
}

struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(UserAuthState())
    }
}

