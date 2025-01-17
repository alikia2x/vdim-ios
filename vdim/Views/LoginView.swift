import SwiftUI

enum AuthState {
    case login
    case register
}

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

private struct LoginRegisterSwitcher: View {
    @Binding var currentState: AuthState

    var body: some View {
        HStack(alignment: .bottom) {
            Text("登录")
                .font(
                    currentState == .login
                        ? .system(size: 32, weight: .bold)
                        : .system(size: 26, weight: .medium)
                )
                .foregroundColor(
                    currentState == .login ? .blue : Color(hex: "#F8FBFF")
                )
                .onTapGesture {
                    currentState = .login
                }

            Text("注册")
                .font(
                    currentState == .register
                        ? .system(size: 32, weight: .bold)
                        : .system(size: 26, weight: .medium)
                )
                .foregroundColor(
                    currentState == .register ? .blue : Color(hex: "#F8FBFF")
                )
                .onTapGesture {
                    currentState = .register
                }
            Spacer()
        }
        .padding(.leading, 12)
    }
}

struct LoginView: View {
    @State private var currentState: AuthState = .login
    @State private var username: String=""
    @State private var secretcode:String=""
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)

            Image("LoginBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width * 1.4)
                .offset(y: -50)
                .opacity(0.56)

            VStack(alignment: .leading, spacing: 8) {
                Title()
                // 为什么这里的alignment不生效
                VStack(alignment: .leading) {
                    LoginRegisterSwitcher(currentState: $currentState)
                        .padding(.top, 24)
                        .padding(.leading, 12)
                    TextField(text: $username){
                        Text("用户名")
                    }
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    Spacer()
                    TextField(text: $secretcode){
                        Text("密码")
                    }
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width - 48, height: 480)
                .background(
                    .thinMaterial, in: RoundedRectangle(cornerRadius: 13)
                )
                .padding(.top, 16)

            }
            .frame(
                maxWidth: UIScreen.main.bounds.width,
                maxHeight: UIScreen.main.bounds.height, alignment: .topLeading
            )
            .padding(.top, 250)
            .padding(.leading, 48)
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexSanitized.hasPrefix("#") {
            hexSanitized.remove(at: hexSanitized.startIndex)
        }

        var rgb: UInt64 = 0
        let scanner = Scanner(string: hexSanitized)
        guard scanner.scanHexInt64(&rgb) else {
            return nil  // 如果扫描失败，返回 nil
        }

        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}

