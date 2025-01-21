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
        VStack {
            ForEach(networkManager.threads, id: \.id) { thread in
                Text(thread.title)
            }
        }
        .onAppear {
            networkManager.fetchThreads()
        }
    }
}

#Preview {
    Timeline()
}
