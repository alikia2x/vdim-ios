import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("主页")
                }

            SectionView()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("板块")
                }

            MusicView()
                .tabItem {
                    Image(systemName: "music.note")
                    Text("音乐")
                }

            UserView()
                .tabItem {
                    Image(systemName: "person")
                    Text("用户")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
