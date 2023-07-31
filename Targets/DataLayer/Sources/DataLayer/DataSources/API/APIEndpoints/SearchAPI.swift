//
//  SearchAPI.swift
//  
//
//  Created by TAE SU LEE on 2022/11/15.
//

import TSCore
import Foundation
import Moya

public typealias SearchAPIService = APIService<SearchAPI>

public enum SearchAPI {
    case readItems(String)
}

extension SearchAPI: TargetType {
    public var baseURL: URL {
        switch AppConfiguration.shared.environment {
        case .prod:
            return URL(string: "https://api.github.com")!
        case .stg:
            return URL(string: "https://api.stg.github.com")!
        case .dev:
            return URL(string: "https://api.dev.github.com")!
        }
    }
    
    public var path: String {
        switch self {
        case .readItems:
            return "/search/repositories"
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
        case .readItems(let query):
            return .requestParameters(parameters: ["q": query, "page": 1], encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String: String]? {
        switch self {
        case .readItems:
            return nil
        }
    }
}
