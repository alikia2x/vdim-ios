//
//  NetworkManager.swift
//  vdim
//
//  Created by Alikia2x on 2025/1/18.
//

import Moya
import Foundation

enum VDimService {
    case getThreads(page: Int = 1)
    case getThread(tid: Int)
}

extension VDimService: TargetType {
    var baseURL: URL { return URL(string: "https://api.lty.fan")! }
    
    var path: String {
        switch self {
        case .getThreads:
            return "/threads"
        case .getThread:
            return "/posts"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getThreads:
            return .get
        case .getThread:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .getThread(tid):
            return .requestParameters(parameters: ["tid": tid], encoding: URLEncoding.queryString)
        case let .getThreads(page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.queryString)
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getThread(let id):
            guard let url = Bundle.main.url(forResource: "accounts", withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        case .getThreads(let page):
            guard let url = Bundle.main.url(forResource: "accounts", withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        }
    }
    
    
    var headers: [String: String]? {
        return nil
    }
    
}
