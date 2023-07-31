//
//  SearchClient.swift
//  TCATuistUI
//
//  Created by TAE SU LEE on 2023/07/04.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import DataLayer
import ComposableArchitecture
import Foundation
import XCTestDynamicOverlay

// MARK: - API models
struct SearchEntityItems: Decodable, Equatable, Sendable {
    let totalCount: Int?
    let items: [SearchEntity]
    
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}

struct SearchEntity: Decodable, Equatable, Identifiable, Sendable {
    let id = UUID()
    let fullName: String?
    let description: String?
    let htmlUrl: String?
    let owner: OwnerEntity?
    
    private enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case description
        case htmlUrl = "html_url"
        case owner
    }
}
    
struct OwnerEntity: Decodable, Equatable, Sendable {
    let avatarUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
    }
}

// MARK: - API client interface
struct SearchClient {
    var fetch: @Sendable (String) async throws -> SearchEntityItems
}

extension DependencyValues {
    var searchClient: SearchClient {
        get { self[SearchClient.self] }
        set { self[SearchClient.self] = newValue }
    }
}

extension SearchClient: DependencyKey {
    static let liveValue = Self(
        fetch: { query in
            let service = SearchAPIService()
            let data = try await service.request(.readItems(query))
            return try jsonDecoder.decode(SearchEntityItems.self, from: data)
        }
    )
    
    static let previewValue = Self(
        fetch: { query in
            try await Task.sleep(nanoseconds: NSEC_PER_SEC)
            let data = JSONFile.Search.readItems200.sampleData ?? Data()
            return try jsonDecoder.decode(SearchEntityItems.self, from: data)
        }
    )
    
    static let testValue = Self(
        fetch: unimplemented("\(Self.self).fetch")
    )
}

// MARK: - Private helpers
private let jsonDecoder: JSONDecoder = {
  let decoder = JSONDecoder()
  let formatter = DateFormatter()
  formatter.calendar = Calendar(identifier: .iso8601)
  formatter.dateFormat = "yyyy-MM-dd"
  formatter.timeZone = TimeZone(secondsFromGMT: 0)
  formatter.locale = Locale(identifier: "en_US_POSIX")
  decoder.dateDecodingStrategy = .formatted(formatter)
  return decoder
}()
