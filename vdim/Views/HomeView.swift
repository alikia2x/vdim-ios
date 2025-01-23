import SDWebImageSwiftUI
import SwiftUI

private struct Background: View {
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
                .frame(height: 72)
            Image("HomeHeader")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 72)
                .offset(y: -40)
                .mask(
                    Rectangle()
                        .ignoresSafeArea()
                )
            LinearGradient(
                gradient: Gradient(
                    colors: [
                        Color(hex: "#2A294DC0"),
                        Color(.white).opacity(0),
                    ]
                ),
                startPoint: .bottom,
                endPoint: .top)
        }
    }
}

struct AvatarView: View {
    var url: String
    var size: CGFloat

    public var body: some View {
        WebImage(url: URL(string: url), options: [.refreshCached, .fromLoaderOnly]) { image in
            image.resizable()
                .frame(width: size, height: size)
                .scaledToFill()
                .clipShape(Circle())
        } placeholder: {
            Image(systemName: "person")
                .foregroundColor(.primary)
                .font(.system(size: size / 2))
                .frame(width: size, height: size)
                .background(
                    .thinMaterial,
                    in: Circle()
                )
        }
        .frame(width: size, height: size)
    }

    // Initializer
    public init(url: String, size: CGFloat) {
        self.url = url
        self.size = size
    }
}

private struct SearchBar: View {
    @Binding var searchText: String

    var body: some View {
        TextField(
            "", text: $searchText,
            prompt: Text("搜索")
                .foregroundColor(Color("HomepageSearchPlaceholder"))
        )
        .foregroundColor(.white)
        .padding(.leading, 8)
        .frame(height: 32)
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 9)
        )
    }
}

private struct MessageButton: View {
    var body: some View {
        Button {
            print("message button clicked")
        } label: {
            Image(systemName: "envelope")
                .font(.system(size: 18))
                .foregroundColor(.white)
                .frame(width: 32, height: 32)
        }
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 9)
        )
    }
}

private struct TopBar: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            AvatarView(url: HomeViewPreviewAvatarURL, size: 40)
            SearchBar(searchText: $searchText)
            MessageButton()
        }
        .padding(.horizontal, 12)
        .ignoresSafeArea(edges: .vertical)
    }
}

private struct TabView: View {
    @Binding var selectedTab: Int
    private let tabs = ["推荐", "热门", "最新", "关注", "收藏"]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 24) {
                ForEach(Array(tabs.enumerated()), id: \.offset) { index, tab in
                    Button(action: {
                        selectedTab = index
                    }) {
                        VStack {
                            Spacer()
                            Text(tab)
                                .foregroundColor(
                                    selectedTab == index
                                        ? Color.accentColor
                                        : Color.primary.opacity(0.8)
                                )
                            Spacer()
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

struct HomeView: View {
    @State private var searchText = ""
    @State private var selectedTab = 2

    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading, spacing: 0) {
                ZStack {
                    Background()
                    TopBar(searchText: $searchText)
                }
                VStack(spacing: 0) {
                    TabView(selectedTab: $selectedTab)
                        .frame(width: geo.size.width, height: 40)
                        .clipped()

                    Timeline()
                        .frame(
                            width: geo.size.width, height: geo.size.height - 112
                        )
                        .mask {
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: .clear, location: 0.0),
                                    .init(color: .black, location: 0.03),
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        }
                        .offset(y: -6)

                }
                .background(Color("HomepageBackground"))
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}
#Preview {
    HomeView()
}
