//
//  ITunesSearcher.swift
//  ITunesStartProject
//
//  Created by Artem Zemtsov on 12/04/2018.
//  Copyright © 2018 Artem Zemtsov. All rights reserved.
//

import Foundation
import Moya

public enum ITunesSearchTarget:APITarget {
    case GetSongs(searchString:String)
}

extension ITunesSearchTarget {
    public var path: String {
        switch self {
        case .GetSongs(_):
            return "search"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .GetSongs(_):
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .GetSongs(let searchString):
            var countryCodeISO:String = "US";
            if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
                countryCodeISO = countryCode
            }
            return .requestParameters(parameters: ["term" : searchString,"media":"music","country":countryCodeISO], encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-type": "application/json",
                "Accept" : "application/json"]
    }
    
    public var validate: Bool { return false }
    
    public var sampleData: Data {
        return Data()
    }
    
}
