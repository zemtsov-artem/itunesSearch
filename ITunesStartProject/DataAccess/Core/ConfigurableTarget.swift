//
//  ConfigurableTarger.swift
//  ITunesStartProject
//
//  Created by Artem Zemtsov on 12/04/2018.
//  Copyright © 2018 Artem Zemtsov. All rights reserved.
//

import Foundation
import Moya

enum SongGetterService {
    case getSongs(page: Int?, perPage: Int?)
    case getSongsImage(songsArtworksURL:[String])
}

public struct ConfigurableTarget : TargetType {
    
    let target : APITarget
    
    public var baseURL: URL { return URL(string: "http://itunes.apple.com")! }
    public var path: String { return target.path }
    public var method: Moya.Method { return target.method }
    public var sampleData: Data { return target.sampleData }
    public var task: Task { return target.task }
    public var headers: [String : String]? { return target.headers }
}


