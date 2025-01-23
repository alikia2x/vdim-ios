//
//  LoginContent.swift
//  vdim
//
//  Created by Alikia2x on 2025/1/18.
//

import SwiftUI


private struct GradientTitle: View {
    var text: String
    var fontSize: CGFloat

    var body: some View {
        Text(text)
            .font(Font.custom("Alimama ShuHeiTi Bold", size: fontSize))
            .foregroundColor(.clear)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(
                            red: 216 / 255, green: 136 / 255, blue: 242 / 255),
                        Color(
                            red: 200 / 255, green: 141 / 255, blue: 255 / 255),
                        Color(
                            red: 136 / 255, green: 165 / 255, blue: 254 / 255),
                        Color(
                            red: 102 / 255, green: 204 / 255, blue: 255 / 255),
                    ]),
                    startPoint: .top,
                    endPoint: .bottomTrailing
                )
                .mask(
                    Text(text).font(
                        Font.custom("Alimama ShuHeiTi Bold", size: fontSize)))
            )
    }
}

private struct Title: View {
    var body: some View {
        VStack(alignment: .leading, spacing: -5) {
            Glow {
                Text("欢迎来到")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
            }
            Glow {
                GradientTitle(text: "V次元", fontSize: 52)
            }
        }
    }
}

private struct MainFrame: View {
    @EnvironmentObject var userAuth: UserAuthState

    var body: some View {
        VStack(alignment: .leading) {
            LoginRegisterSwitcher()
                .padding(.top, 24)
                .padding(.leading, 12)
            ZStack {
                LoginForm()
                    .offset(x: (1 - CGFloat(userAuth.action)) * screenSize.width)
                    .animation(.spring(duration: 0.35), value: UUID())
                RegisterStep1()
                    .offset(x: (2 - CGFloat(userAuth.action)) * screenSize.width)
                    .animation(.spring(duration: 0.35), value: UUID())
                RegisterStep2()
                    .offset(x: (3 - CGFloat(userAuth.action)) * screenSize.width)
                    .animation(.spring(duration: 0.35), value: UUID())
            }
            .clipped()
            
            Spacer()
        }
        .frame(
            width: screenSize.width - 48,
            height: screenSize.height > 700 ? 440 : 400
        )
        .background(
            .thinMaterial, in: RoundedRectangle(cornerRadius: 13)
        )
        .padding(.top, 16)
    }
}

private struct LoginRegisterSwitcher: View {
    @EnvironmentObject var userAuth: UserAuthState

    var body: some View {
        HStack(alignment: .bottom, spacing: 12) {
            Text("登录")
                .font(
                    userAuth.action == 1
                        ? .system(size: 32, weight: .bold)
                        : .system(size: 26, weight: .medium)
                )
                .foregroundColor(
                    userAuth.action == 1 ? .blue : Color(hex: "#F8FBFF")
                )
                .onTapGesture {
                    userAuth.action = 1
                    clearAuthState()
                }
                .animation(.spring(duration: 0.2), value: UUID())

            Text("注册")
                .font(
                    userAuth.action > 1
                        ? .system(size: 32, weight: .bold)
                        : .system(size: 26, weight: .medium)
                )
                .foregroundColor(
                    userAuth.action > 1 ? .blue : Color(hex: "#F8FBFF")
                )
                .onTapGesture {
                    userAuth.action = 2
                    clearAuthState()
                }
                .animation(.spring(duration: 0.2), value: UUID())

            Spacer()
        }
        .padding(.leading, 12)
    }
    func clearAuthState() {
        userAuth.email = ""
        userAuth.username = ""
        userAuth.password = ""
        userAuth.phoneNumber = ""
        userAuth.TFACode = ""
    }
}

struct LoginContent: View {
    @EnvironmentObject var userAuth: UserAuthState
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Title()
            MainFrame()
                .environmentObject(userAuth)
        }
        .frame(
            maxWidth: screenSize.width,
            maxHeight: screenSize.height, alignment: .topLeading
        )
        .padding(getContentPadding())
    }
}


struct LoginContent_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(UserAuthState())
    }
}
