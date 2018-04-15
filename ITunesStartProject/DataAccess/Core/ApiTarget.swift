//
//  ApiTarget.swift
//  ITunesStartProject
//
//  Created by Artem Zemtsov on 12/04/2018.
//  Copyright © 2018 Artem Zemtsov. All rights reserved.
//

import Moya

public protocol APITarget {
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    
    /// The HTTP method used in the request.
    var method: Moya.Method { get }
    
    /// The type of HTTP task to be performed.
    var task: Task { get }
    
    /// The headers to be used in the request.
    var headers: [String: String]? { get }
    
    /// Provides stub data for use in testing.
    var sampleData: Data { get }
}

