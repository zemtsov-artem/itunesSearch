//
//  SongModel.swift
//  ITunesStartProject
//
//  Created by Artem Zemtsov on 11/04/2018.
//  Copyright © 2018 Artem Zemtsov. All rights reserved.
//

import Foundation

public struct SongModelListResult:Decodable{
    var resultCount:Int
    var results: [SongModelProperties]
}

public struct SongModel:Decodable{
    var artistId:Int?;
    var trackId:Int?;
    var artistName:String?;
    var trackName:String?;
    var artworkUrl100:String?;
    var trackTimeMillis:Int?;
    var previewUrl:String?;
}

public struct SongModelProperties:Decodable{
    var wrapperType:String?;
    var kind:String?;
    var artistId:Int?;
    var collectionId:Int?;
    var trackId:Int?;
    var artistName:String?;
    var collectionName:String?;
    var trackName:String?;
    var artistViewUrl:String?;
    var collectionViewUrl:String?;
    var trackViewUrl:String?;
    var previewUrl:String?;
    var artworkUrl30:String?;
    var artworkUrl60:String?;
    var artworkUrl100:String?;
    var trackExplicitness:String?;
    var trackNumber:Int?;
    var trackTimeMillis:Int?;
    var currency:String?;
    var isStreamable:Bool?;
}
