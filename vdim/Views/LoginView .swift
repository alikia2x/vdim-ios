import SwiftUI

enum AuthState {
    case login
    case register
}

let screenSize = UIScreen.main.bounds

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
        HStack(alignment: .bottom, spacing: 12) {
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
                .animation(.spring(duration: 0.2), value: UUID())

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
                .animation(.spring(duration: 0.2), value: UUID())
                
            
            Spacer()
        }
        .padding(.leading, 12)
    }
}

private struct LoginForm: View {
    @Binding var username: String
    @Binding var password: String

    var body: some View {
        VStack(alignment: .leading) {
            Text("用户名")
                .padding(.leading, 24)
            TextField("", text: $username, prompt: Text("输入用户名").foregroundColor(Color(.loginFormTextFieldPlaceholder)))
                .padding(12)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color(.loginFormTextFieldBackground)))
                .padding([.leading, .trailing], 24)
                .autocorrectionDisabled()
                .onAppear{
                    UITextField.appearance().clearButtonMode = .whileEditing
                }
            Text("密码")
                .padding(.leading, 24)
                .padding(.top, 24)
            SecureField("", text: $password, prompt: Text("输入密码").foregroundColor(Color(.loginFormTextFieldPlaceholder)))
                .padding(12)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color(.loginFormTextFieldBackground)))
                .padding([.leading, .trailing], 24)
                .autocorrectionDisabled()
        }
        .padding(.top, 8)
        .onAppear{
            UITextField.appearance().clearButtonMode = .whileEditing
        }
    }
}

private struct Background: View {
    var body: some View {
        Color.black
            .edgesIgnoringSafeArea(.all)
        Image("LoginBackground")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: screenSize.width * 1.4)
            .offset(y: -50)
            .opacity(0.56)
    }
}

struct MainFrame: View {
    @Binding var username: String
    @Binding var password: String
    @Binding var currentAction: AuthState
    
    var body: some View {
        VStack(alignment: .leading) {
            LoginRegisterSwitcher(currentState: $currentAction)
                .padding(.top, 24)
                .padding(.leading, 12)
            
            LoginForm(username: $username, password: $password)
            
            Spacer()
        }
        .frame(width: screenSize.width - 48, height: screenSize.height > 700 ? 440 : 400 )
        .background(
            .thinMaterial, in: RoundedRectangle(cornerRadius: 13)
        )
        .padding(.top, 16)
    }
}

func getContentPadding() -> EdgeInsets {
    let screenSize = screenSize
    let width = min(screenSize.width, screenSize.height)

    switch width {
    case 0..<380:
        return EdgeInsets(top: 180, leading: 48, bottom: 0, trailing: 0)
    case 380..<440:
        return EdgeInsets(top: 250, leading: 48, bottom: 0, trailing: 0)
    default:
        return EdgeInsets(top: 300, leading: 48, bottom: 0, trailing: 0)
    }
}

struct LoginView: View {
    @State private var currentAction: AuthState = .login
    @State private var username: String = ""
    @State private var password: String = ""

    var body: some View {
        ZStack {
            Background()
            
            VStack(alignment: .leading, spacing: 8) {
                Title()
                MainFrame(username: $username, password: $password, currentAction: $currentAction)
            }
            .frame(
                maxWidth: screenSize.width,
                maxHeight: screenSize.height, alignment: .topLeading
            )
            .padding(getContentPadding())
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


extension Color {
    init(hex: String) {
        @Environment(\.colorScheme) var colorScheme
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexSanitized.hasPrefix("#") {
            hexSanitized.remove(at: hexSanitized.startIndex)
        }
        
        var r: Double = 0
        var g: Double = 0
        var b: Double = 0
        var a: Double = 1.0
        
        switch hexSanitized.count {
        case 3:
            if let rgb = UInt64(hexSanitized, radix: 16) {
                r = Double((rgb >> 8) & 0xF) / 15.0
                g = Double((rgb >> 4) & 0xF) / 15.0
                b = Double(rgb & 0xF) / 15.0
            }
        case 4:
            if let rgba = UInt64(hexSanitized, radix: 16) {
                r = Double((rgba >> 12) & 0xF) / 15.0
                g = Double((rgba >> 8) & 0xF) / 15.0
                b = Double((rgba >> 4) & 0xF) / 15.0
                a = Double(rgba & 0xF) / 15.0
            }
        case 6:
            if let rgb = UInt64(hexSanitized, radix: 16) {
                r = Double((rgb >> 16) & 0xFF) / 255.0
                g = Double((rgb >> 8) & 0xFF) / 255.0
                b = Double(rgb & 0xFF) / 255.0
            }
        case 8:
            if let rgba = UInt64(hexSanitized, radix: 16) {
                r = Double((rgba >> 24) & 0xFF) / 255.0
                g = Double((rgba >> 16) & 0xFF) / 255.0
                b = Double((rgba >> 8) & 0xFF) / 255.0
                a = Double(rgba & 0xFF) / 255.0
            }
        default:
            break
        }
        
        self.init(red: r, green: g, blue: b, opacity: a)
    }
}

