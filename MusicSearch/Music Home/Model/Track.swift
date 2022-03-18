//
//  Song.swift
//  MusicSearch
//
//  Created by kumaresh shrivastava on 16/03/2022.
//

import Foundation

struct TrackResponse: Codable{
    let track : TrackResults

    enum CodingKeys: String, CodingKey {
        case track = "results"
    }
}

struct TrackResults: Codable {
    var trackMatches: TrackMatches

    enum CodingKeys: String, CodingKey {
        case trackMatches = "trackmatches"
    }
}

struct TrackMatches: Codable {
    let matches : [Tracks]?

    enum CodingKeys: String, CodingKey {
        case matches = "track"
    }
}

struct Tracks: Codable {
     let title: String
     let name: String
     let images: [MusicImage]

    enum CodingKeys: String, CodingKey {
        case title = "name"
        case name = "artist"
        case images = "image"
    }
}

struct TrackImage: Codable{
    let url: String
    let size: String

    enum CodingKeys: String, CodingKey{
        case url = "#text"
        case size
    }
}
