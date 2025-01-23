//
//  Timeline.swift
//  vdim
//
//  Created by Alikia2x on 2025/1/5.
//

import SwiftUI

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
                                AvatarView(url: thread.author.avatar, size: 36)
                                VStack (alignment: .leading, spacing: 6){
                                    Text(thread.author.name)
                                        .font(.system(size: 16))
                                    // TODO: Compiler is unable to typ-check in reasonable time;
//                                    Text(formatRelativeDate(thread.createdAt))
//                                        .font(.system(size: 13))
//                                        .foregroundStyle(.subheadline)
                                }
                            }
                            Text(thread.title)
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
