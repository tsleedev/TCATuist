//  
//  HomeAPI.swift
//  
//
//  Created by TAE SU LEE on 2023/03/14.
//

import Foundation
import Moya

public typealias HomeAPIService = APIService<HomeAPI>

public enum HomeAPI {
//    case readItems
//    case readItem
}

extension HomeAPI: TargetType {
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
//        switch self {
//        case .readItems:
//            return "/items"
//        case .readItem:
//            return "/item"
//        }
        return ""
    }
    
    public var method: Moya.Method {
//        switch self {
//        case .readItems, .readItem:
//            return .get
//        }
        return .get
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Moya.Task {
//        switch self {
//        case .readItems, .readItem:
//            return .requestPlain
//        }
        return .requestPlain
    }
    
    public var headers: [String: String]? {
//        switch self {
//        case .readItems, .readItem:
//            return .nil
//        }
        return nil
    }
}
