//
//  NetworkManager.swift
//  vdim
//
//  Created by Alikia2x on 2025/1/19.
//

import Moya
import Combine
import Foundation

struct Post: Codable, Identifiable {
    let id: Int                 // 帖子ID，tid
    let author: UserLite        // 作者
    let content: String         // 帖子内容
    let createdAt: Int          // 创建时间，dateline
    let ipLocation: String      // IP属地
    let likes: Int              // 点赞量，recommends
    let replies: Int            // 评论量
    let tags: [Tag]             // 标签，若无则为空数组
    let title: String           // 帖子标题，subject
    let updatedAt: Int?         // 修改时间，若无编辑则为NULL
    let views: Int              // 浏览量
}

struct Tag: Codable {
    let id: Int                 // 标签 ID
    let name: String            // 标签内容
}

struct UserLite: Codable {
    let id: Int                 // uid
    let avatar: String          // 头像 URL
    let name: String            // 用户名
    let signature: String?      // 签名
}

class NetworkManager: ObservableObject {
    private var provider = MoyaProvider<VDimService>()
    @Published var threads: [Post] = []

    func fetchThreads(page: Int = 1) {
        provider.request(.getThreads(page: page, useMock: true)) { result in
            switch result {
            case let .success(response):
                do {
                    let threads = try JSONDecoder().decode([Post].self, from: response.data)
                    DispatchQueue.main.async {
                        self.threads = threads
                    }
                } catch {
                    print("Error decoding threads: \(error)")
                }
            case let .failure(error):
                print("Error fetching threads: \(error)")
            }
        }
    }
}
