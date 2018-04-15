//
//  ITunesSearchRepository.swift
//  ITunesStartProject
//
//  Created by Artem Zemtsov on 12/04/2018.
//  Copyright © 2018 Artem Zemtsov. All rights reserved.
//

import Foundation
import PromiseKit

protocol ITunesSearchRepositoryType {
    func getSongs(searchString: String, fresh: Bool) -> Promise<[SongModel]>
}

class ITunesSearchRepository : ITunesSearchRepositoryType {
    
    private var songModels : [String : [SongModel]] = [:]
    
    private let client : ITunesSearchClientType
    
    init(client: ITunesSearchClientType) {
        self.client = client
    }
    
    func getSongs(searchString: String, fresh: Bool = true) -> Promise<[SongModel]> {
        if !fresh, let details = songModels[searchString] {
            return Promise.value(details)
        } else {
            let request = client.getSongs(searchString: searchString)
            let resRequest = request.then({ result -> Promise<[SongModel]> in
                var songModels:[SongModel] = []
                for songModel in result.results{
                    let song = SongModel(artistId: songModel.artistId, trackId: songModel.trackId, artistName: songModel.artistName, trackName: songModel.trackName, artworkUrl100: songModel.artworkUrl100, trackTimeMillis: songModel.trackTimeMillis, previewUrl: songModel.previewUrl)
                    songModels.append(song)
                }
                self.songModels[searchString] = songModels
                return Promise.value(songModels)
            })
            return resRequest
        }
    }
}

