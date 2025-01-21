//
//  NetworkManager.swift
//  vdim
//
//  Created by Alikia2x on 2025/1/19.
//

import Moya
import Combine
import Foundation

struct Thread: Codable, Identifiable {
    let tid: Int
    let fid: Int
    let posttableid: Int
    let typeid: Int
    let sortid: Int
    let readperm: Int
    let price: Int
    let author: String
    let authorid: Int
    let subject: String
    let dateline: TimeInterval
    let lastpost: TimeInterval
    let lastposter: String
    let views: Int
    let replies: Int
    let displayorder: Bool
    let highlight: Bool
    let digest: Bool
    let rate: Bool
    let special: Bool
    let attachment: Bool
    let moderated: Bool
    let closed: Int
    let stickreply: Bool
    let recommends: Int
    let recommend_add: Int
    let recommend_sub: Int
    let heats: Int
    let status: Int
    let isgroup: Bool
    let favtimes: Int
    let sharetimes: Int
    let stamp: Int
    let icon: Int
    let pushedaid: Int
    let cover: Int
    let replycredit: Int
    let relatebytag: String
    let maxposition: Int
    let bgcolor: String
    let comments: Int
    let hidden: Int

    var id: Int {
        return tid
    }
}

class NetworkManager: ObservableObject {
    private var provider = MoyaProvider<VDimService>()
    @Published var threads: [Thread] = []

    func fetchThreads(page: Int = 1) {
        print("Hello")
        provider.request(.getThreads(page: page)) { result in
            switch result {
            case let .success(response):
                do {
                    let threads = try JSONDecoder().decode([Thread].self, from: response.data)
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
