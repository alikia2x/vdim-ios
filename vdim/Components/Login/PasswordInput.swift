import SwiftUI
import zxcvbn

func checkPassword(password: String) -> Double {
    if password == "" {
        return 0
    }
    let result = zxcvbn(password)
    let score = log2(result.guesses)
    return score
}

struct PasswordInput: View {
    @Binding var password: String
    let showStrength: Bool
    @State private var isPasswordVisible: Bool = false
    @State private var passwordScore: Double = 0
    @FocusState private var textIsFocused: Bool
    @FocusState private var passwordIsFocused: Bool

    var body: some View {
        VStack {
            ZStack(alignment: .trailing) {
                if isPasswordVisible {
                    TextField(
                        "",
                        text: $password,
                        prompt:
                            Text(showStrength ? "设置密码…" : "输入密码")
                            .foregroundColor(
                                Color("LoginFormTextFieldPlaceholder"))
                    )
                    .padding(.trailing, 40)
                    .frame(maxWidth: .infinity, maxHeight: 48)
                    .padding(.leading, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 8).fill(
                            Color(.loginFormTextFieldBackground))
                    )
                    .autocorrectionDisabled()
                    .font(.system(.body, design: .monospaced))
                    .focused($textIsFocused)
                } else {
                    SecureField(
                        "", text: $password,
                        prompt: Text(showStrength ? "设置密码…" : "输入密码").foregroundColor(
                            Color("LoginFormTextFieldPlaceholder"))
                    )
                    .padding(.trailing, 40)
                    .frame(maxWidth: .infinity, maxHeight: 48)
                    .padding(.leading, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(.loginFormTextFieldBackground))
                    )
                    .autocorrectionDisabled()
                    .focused($passwordIsFocused)
                }

                Button(action: {
                    if (passwordIsFocused) {
                        textIsFocused = true
                    }
                    else if (textIsFocused) {
                        passwordIsFocused = true
                    }
                    isPasswordVisible.toggle()
                }) {
                    Image(
                        systemName: isPasswordVisible
                            ? "eye.slash.fill" : "eye.fill"
                    )
                    .foregroundColor(.gray)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.trailing, 12)
            }
            .frame(height: 48)
            .clipped()
            if (showStrength) {
                ProgressView(value: min(passwordScore, 70), total: 70) {
                    Text("强度")
                        .font(.callout)
                }
                .tint(getColor(for: passwordScore))
                .frame(maxHeight: 20)
                .padding(.top, 14)
            }
        }
        .padding([.leading, .trailing], 24)
        .onChange(of: password) { newValue in
            if (!showStrength) {
                return;
            }
            DispatchQueue.global(qos: .userInitiated).async {
                let score = checkPassword(password: newValue)
                DispatchQueue.main.async {
                    passwordScore = score
                }
            }
        }
    }
    func mapValueToColor(value: CGFloat) -> Color {
        let clampedValue = max(0, min(1, value))
        let hue = clampedValue * 120 / 360
        let lightness = 1.0
        let saturation: CGFloat = 1.0
        return Color(hue: hue, saturation: saturation, brightness: lightness)
    }
    func getColor(for score: Double) -> Color {
        return mapValueToColor(value: score / 70)
    }
}

struct PasswordInputPreview: View {
    @State var password = ""
    @State var showingStrength = false
    var body: some View {
        VStack {
            PasswordInput(password: $password, showStrength: showingStrength)
            Button(action: {
                showingStrength.toggle()
            })
            {
                Text("Toggle")
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 24)
        }
    }
}

struct PasswordInput_Previews: PreviewProvider {
    static var previews: some View {
        PasswordInputPreview()
    }
}
