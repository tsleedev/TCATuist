//
//  AppConfiguration.swift
//  DataLayer
//
//  Created by TAE SU LEE on 2023/07/07.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import Foundation

public enum AppEnvironment {
    case dev
    case stg
    case prod
}

public final class AppConfiguration {
    public static let shared = AppConfiguration()
    
    public var environment: AppEnvironment = .prod

    private init() {}
}
