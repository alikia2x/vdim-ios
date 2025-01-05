import SwiftUI

struct PostEditorView: View {
    @State private var postContent = ""
    
    var body: some View {
        VStack {
            // 顶部工具栏
            HStack {
                Button("取消") {
                    // 取消操作
                }
                
                Spacer()
                
                Button("发布") {
                    // 发布操作
                }
            }
            .padding()
            
            // 文本编辑区域
            TextEditor(text: $postContent)
                .padding()
            
            // 底部工具栏
            HStack {
                Button(action: {}) {
                    Image(systemName: "photo")
                }
                
                Button(action: {}) {
                    Image(systemName: "video")
                }
                
                Button(action: {}) {
                    Image(systemName: "link")
                }
                
                Spacer()
            }
            .padding()
        }
    }
}
