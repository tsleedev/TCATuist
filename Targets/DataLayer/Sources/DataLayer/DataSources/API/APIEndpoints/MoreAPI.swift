//
//  MoreAPI.swift
//  
//
//  Created by TAE SU LEE on 2023/02/06.
//

import Foundation
import Moya

public typealias MoreAPIService = APIService<MoreAPI>

public enum MoreAPI {
    case readItems
}

extension MoreAPI: TargetType {
    public var baseURL: URL {
        switch AppConfiguration.shared.environment {
        case .prod:
            return URL(string: "https://api-production.example.com")!
        case .stg:
            return URL(string: "https://api-stg.example.com")!
        case .dev:
            return URL(string: "https://api-debug.example.com")!
        }
    }

    public var path: String {
        switch self {
        case .readItems:
            return "/more/list"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .readItems:
            return .get
        }
    }

    public var sampleData: Data {
        return Data()
    }

    public var task: Moya.Task {
        switch self {
        case .readItems:
            return .requestPlain
        }
    }

    public var headers: [String: String]? {
        switch self {
        case .readItems:
            return nil
        }
    }
}
