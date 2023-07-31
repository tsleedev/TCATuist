//
//  MoreClient.swift
//  TCATuistUI
//
//  Created by TAE SU LEE on 2023/07/07.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import DataLayer
import ComposableArchitecture
import Foundation
import XCTestDynamicOverlay

// MARK: - API models
struct MoreEntityItems: Decodable, Equatable, Sendable {
    let items: [MoreEntity]
}

struct MoreEntity: Decodable, Equatable, Identifiable, Sendable {
    let id = UUID()
    let title: String
    
    enum CodingKeys: CodingKey {
        case title
    }
}

// MARK: - API client interface
struct MoreClient {
    var fetch: @Sendable () async throws -> [MoreEntity]
}

extension DependencyValues {
    var moreClient: MoreClient {
        get { self[MoreClient.self] }
        set { self[MoreClient.self] = newValue }
    }
}

extension MoreClient: DependencyKey {
    static let liveValue = Self(
        fetch: {
//            let service = MoreAPIService()
//            let data = try await service.request(.readItems)
//            return try jsonDecoder.decode(MoreEntityItems.self, from: data)
            try await Task.sleep(nanoseconds: NSEC_PER_SEC)
            let data = JSONFile.More.readItems200.sampleData ?? Data()
            return try jsonDecoder.decode(MoreEntityItems.self, from: data).items
        }
    )
    
    static let previewValue = Self(
        fetch: {
            try await Task.sleep(nanoseconds: NSEC_PER_SEC)
            let data = JSONFile.More.readItems200.sampleData ?? Data()
            return try jsonDecoder.decode(MoreEntityItems.self, from: data).items
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
