import Combine
import SwiftUI

class UserAuthState: ObservableObject {
    @Published var username: String
    @Published var password: String
    @Published var phoneNumber: String
    @Published var TFACode: String
    @Published var email: String
    @Published var action: Int

    init(
        username: String = "", password: String = "", phoneNumber: String = "",
        TFACode: String = "", email: String = "", action: Int = 1
    ) {
        self.username = username
        self.password = password
        self.phoneNumber = phoneNumber
        self.TFACode = TFACode
        self.email = email
        self.action = action
    }
}

let screenSize = UIScreen.main.bounds

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

struct LoginView: View {
    var body: some View {
        ZStack {
            Background()

            LoginContent()
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(UserAuthState())
    }
}
