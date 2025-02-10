//
//  NetworkManager.swift
//  vdim
//
//  Created by Alikia2x on 2025/1/18.
//

import Moya
import Foundation

enum VDimService {
    case getThreads(page: Int = 1, useMock: Bool)
    case getThread(tid: Int, useMock: Bool)
    case login(username: String, password: String, useMock: Bool)
}

enum ServerEnvironment {
    case real
    case mock
}

protocol BaseTargetType: TargetType {
    var environment: ServerEnvironment { get }
}

extension BaseTargetType {
    var baseURL: URL {
        switch environment {
        case .real:
            return URL(string: realAPIbaseURL)!
        case .mock:
            return URL(string: mockAPIbaseURL)!
        }
    }
}

extension VDimService: BaseTargetType {
    var environment: ServerEnvironment {
        switch self {
        case .getThreads(_, let useMock):
            return useMock ? .mock : .real
        case .getThread(_, let useMock):
            return useMock ? .mock : .real
        case.login(_, _, let useMock):
            return useMock ? .mock : .real
        }
    }
    
    var path: String {
        switch self {
        case .getThreads:
            return "/threads"
        case .getThread:
            return "/posts"
        case .login:
            return "/login"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getThreads:
            return .get
        case .getThread:
            return .get
        case .login:
            return .post
        }
    }

    var task: Task {
        switch self {
        case let .getThread(tid, _):
            return .requestParameters(parameters: ["tid": tid], encoding: URLEncoding.queryString)
        case let .getThreads(page, _):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.queryString)
        case let .login(username, password, _):
            return .requestJSONEncodable(LoginRequest(username: username, password: password))
        }
    }

    var headers: [String: String]? {
        nil
    }

}
