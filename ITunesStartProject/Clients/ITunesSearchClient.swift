//
//  ITunesSearchClient.swift
//  ITunesStartProject
//
//  Created by Artem Zemtsov on 12/04/2018.
//  Copyright © 2018 Artem Zemtsov. All rights reserved.
//

import Foundation
import PromiseKit
import UIKit

protocol ITunesSearchClientType {
    func getSongs(searchString:String) -> Promise<SongModelListResult>
}

public class ITunesSearchClient : ITunesSearchClientType {
    
    private var  provider: CoreProvider<ITunesSearchTarget>
    
    init(provider: CoreProvider<ITunesSearchTarget>) {
        self.provider = provider
    }
    
    public func getSongs(searchString:String) -> Promise<SongModelListResult> {
        return self.provider.request(.GetSongs(searchString: searchString))
    }
}
