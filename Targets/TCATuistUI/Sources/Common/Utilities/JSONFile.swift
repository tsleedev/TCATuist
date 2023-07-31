//
//  JSONFile.swift
//  
//
//  Created by TAE SU LEE on 2023/06/05.
//

import Foundation

protocol JSONFileRepresentable {
    var fileName: String { get }
    var sampleData: Data? { get }
}

enum JSONFile { }

extension JSONFile {
    enum Device {
        case deviceRegist200
    }
    
    enum Search {
        case readItemsNoItems
        case readItems200
        case readItems403
    }
    
    enum More {
        case readItems200
        case readNoItem200
    }
    
    enum Settings {
        case readItems200
    }
}

extension JSONFile.Device: JSONFileRepresentable {
    var fileName: String {
        switch self {
        case .deviceRegist200:
            return "DeviceRegistSampleDataStatusCode200"
        }
    }
    
    var sampleData: Data? {
        return JSONLoader.load(fileName)
    }
}

extension JSONFile.Search: JSONFileRepresentable {
    var fileName: String {
        switch self {
        case .readItemsNoItems:
            return "SearchSampleDataNoItemsStatusCode200"
        case .readItems200:
            return "SearchSampleDataStatusCode200"
        case .readItems403:
            return "SearchSampleDataStatusCode403"
        }
    }
    
    var sampleData: Data? {
        return JSONLoader.load(fileName)
    }
}

extension JSONFile.More: JSONFileRepresentable {
    var fileName: String {
        switch self {
        case .readItems200:
            return "MoreSampleDataStatusCode200"
        case .readNoItem200:
            return "MoreSampleDataNoItemStatusCode200"
        }
    }
    
    var sampleData: Data? {
        return JSONLoader.load(fileName)
    }
}

extension JSONFile.Settings: JSONFileRepresentable {
    var fileName: String {
        switch self {
        case .readItems200:
            return "SettingsSampleDataStatusCode200"
        }
    }
    
    var sampleData: Data? {
        return JSONLoader.load(fileName)
    }
}
