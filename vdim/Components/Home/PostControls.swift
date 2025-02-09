//
//  PostControls.swift
//  vdim
//
//  Created by Alikia2x on 2025/1/26.
//

import SwiftUI

private struct BouncingNumber: View {
    let number: Int
    let countsDown: Bool
    var body: some View {
        if #available(iOS 16.0, *) {
            Text(number, format: .number)
                .contentTransition(.numericText(countsDown: countsDown))
                .foregroundColor(.black)
        } else {
            Text(String(number))
                .foregroundColor(.black)
        }
    }
}

private struct LikeButton: View {
    @State private var postHearted: Bool = false
    @State private var displayLikes: Int
    @State private var isPressed = false
    let likes: Int
    
    init(likes: Int) {
        self.likes = likes
        self._displayLikes = State(initialValue: likes) // Initialize displayLikes with likes
    }
    
    var body: some View {
        
        HStack {
            Button(action: {
                postHearted.toggle()
                withAnimation(.spring(duration: 0.2, bounce: 0.2)) {
                    displayLikes = postHearted ? likes + 1 : likes
                }
            }) {
                ZStack {
                    image(Image(systemName: "heart.fill"), show: postHearted)
                    image(Image(systemName: "heart"), show: !postHearted)
                }
            }
            .scaleEffect(isPressed ? 0.85 : 1)
            .animation(.interpolatingSpring(duration: 0.5, bounce: 0.4), value: isPressed ? 0.85 : 1)
            .onLongPressGesture(minimumDuration: 0, perform: {}) { pressing in
                if pressing {
                    isPressed = true
                }
                else {
                    isPressed = false
                }
            }
            
            BouncingNumber(number: displayLikes, countsDown: postHearted)
                .frame(maxWidth: 40, alignment: .leading)
        }
    }
    
    func image(_ image: Image, show: Bool) -> some View {
        image
            .tint(postHearted ? .red : .black)
            .scaleEffect(show ? 1 : 0)
            .opacity(show ? 1 : 0)
            .animation(.interpolatingSpring(duration: 0.4, bounce: 0.4), value: show)
    }
}

private struct CommentIndicator: View {
    let replies: Int
    var body: some View {
        HStack {
            Image(systemName: "ellipsis.message")
            BouncingNumber(number: replies, countsDown: false)
        }
    }
}

private struct ShareButton: View {
    var body: some View {
        Button(action: {
            // nothing
            print("Share")
        }) {
            Image(systemName: "arrowshape.turn.up.left")
                .tint(.black)
        }
    }
}

struct PostControls: View {
    let post: Post
    
    var body: some View {
        HStack {
            LikeButton(likes: post.likes)
                .frame(maxWidth: 70)
            Spacer()
            CommentIndicator(replies: post.replies)
                .frame(maxWidth: 70)
            Spacer()
            ShareButton()
                .frame(maxWidth: 50, alignment: .trailing)
        }
    }
}

private let sampleThread = Post(id: 712, author: UserLite(id: 412, avatar: "", name: "", signature: nil), content: "", createdAt: Int(Date().timeIntervalSince1970), ipLocation: "", likes: 712, replies: 9, tags: [], title: "", updatedAt: nil, views: 20)

#Preview {
    PostControls(post: sampleThread)
        .scaleEffect(1.6)
        .frame(maxWidth: 200)
}
