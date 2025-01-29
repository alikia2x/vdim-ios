//
//  Timeline.swift
//  vdim
//
//  Created by Alikia2x on 2025/1/5.
//

import SwiftUI

struct TimeIndicator: View {
    let timestamp: Int
    var body: some View {
        Text(formatRelativeDate(timestamp))
            .foregroundStyle(.primary).opacity(0.8)
            .font(.footnote)
    }
}


struct Timeline: View {
    @StateObject private var networkManager = NetworkManager()
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                Spacer(minLength: 12)
                ForEach(networkManager.threads, id: \.id) { thread in
                    HStack {
                        VStack (alignment: .leading, spacing: 14){
                            HStack {
                                AvatarView(url: thread.author.avatar, size: 40)
                                VStack (alignment: .leading, spacing: 4){
                                    Text(thread.author.name)
                                        .font(.callout)
                                        .fontWeight(.medium)
                                    TimeIndicator(timestamp: thread.createdAt)
                                }
                            }
                            Text(thread.title)
                                .font(.title3)
                                .fontWeight(.semibold)
                            Text(thread.content)
                                .lineLimit(2)
                            PostControls(post: thread)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 14)
                    .padding(.horizontal, 14)
                    .background(in: RoundedRectangle(cornerRadius: 6))
                }
                VStack {
                    Text("已经到底啦Σ(っ °Д °;)っ")
                        .padding(.top, 32)
                    Spacer()
                }
                .frame(width: screenSize.width - 24, height: 160)
            }
            .padding(.horizontal, 12)
            .onAppear {
                networkManager.fetchThreads()
            }
        }
    }
}

#Preview {
    HomeView()
}
