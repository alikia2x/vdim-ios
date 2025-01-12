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
                        Color(red: 216 / 255, green: 136 / 255, blue: 242 / 255),
                        Color(red: 200 / 255, green: 141 / 255, blue: 255 / 255),
                        Color(red: 136 / 255, green: 165 / 255, blue: 254 / 255),
                        Color(red: 102 / 255, green: 204 / 255, blue: 255 / 255),
                    ]),
                    startPoint: .top,
                    endPoint: .bottomTrailing
                )
                .mask(Text(text).font(Font.custom("Alimama ShuHeiTi Bold", size: fontSize)))
            )
    }
}



private struct Title: View {
    var body: some View {
        VStack(alignment: .leading, spacing: -5) {
            Glow() {
                Text("欢迎来到")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
            }
            Glow() {
                GradientTitle(text: "V次元", fontSize: 52)
            }
        }
    }
}

struct LoginView: View {
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
            }
            .frame(maxWidth: UIScreen.main.bounds.width,
                   maxHeight: UIScreen.main.bounds.height, alignment: .topLeading)
            .padding(.top, 300)
            .padding(.leading, 48)
        }
    }
}


struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
