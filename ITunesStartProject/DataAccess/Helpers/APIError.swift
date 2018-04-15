//
//  APIError.swift
//  ITunesStartProject
//
//  Created by Artem Zemtsov on 12/04/2018.
//  Copyright © 2018 Artem Zemtsov. All rights reserved.
//

import Foundation

enum ApiErrorCode : String {
    case unauthorized = "401"
    case unavailable = "404"
    case badRequest = "400"
    case serverError = "500"
}

public struct APIError: Decodable, Error {
    let code: String
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case error
    }
    
    enum DetailsCodingKeys: String, CodingKey {
        case code
        case message
    }
    
    public init(from aDecoder: Decoder) throws {
        let values = try aDecoder.container(keyedBy: CodingKeys.self)
        let details = try values.nestedContainer(keyedBy: DetailsCodingKeys.self, forKey: .error)
        self.code = try details.decode(String.self, forKey: .code)
        self.message = try details.decode(String.self, forKey: .message)
        
    }
}
