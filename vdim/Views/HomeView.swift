import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @State private var selectedTab = 0
    @State private var showPostEditor = false

    private let tabs = ["推荐", "热门", "最新", "关注", "收藏"]
    private let tabIcons = [
        "sparkles", "flame",
        "clock.arrow.trianglehead.counterclockwise.rotate.90", "person", "star",
    ]

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                // 顶栏：搜索框+发帖按钮
                HStack {
                    TextField(
                        "搜索...",
                        text: $searchText,
                        prompt: Text("搜索").foregroundColor(.gray)
                    )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray)
                    )

                    Button(action: {
                        showPostEditor = true
                    }) {
                        Image(systemName: "plus")
                            .padding(8)
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                .sheet(isPresented: $showPostEditor) {
                    PostEditorView()
                }

                // 横向滚动tab
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(Array(tabs.enumerated()), id: \.offset) {
                            index, tab in
                            Button(
                                action: {
                                    selectedTab = index
                                }
                            ) {
                                Label(tab, systemImage: tabIcons[index])
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 16)
                                    .background(
                                        selectedTab == index
                                        ? Color.accentColor : Color.secondary
                                    )
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                // 内容区域
                Group {
                    switch selectedTab {
                    case 0:
                        Text("推荐内容")
                    case 1:
                        Text("热门内容")
                    case 2:
                        Text("最新内容")
                    case 3:
                        Text("关注内容")
                    case 4:
                        Text("收藏内容")
                    default:
                        EmptyView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                Spacer()
            }
            .padding(.top)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
