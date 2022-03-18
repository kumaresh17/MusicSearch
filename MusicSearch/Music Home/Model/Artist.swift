//
//  Artist.swift
//  MusicSearch
//
//  Created by kumaresh shrivastava on 16/03/2022.
//
//

import Foundation

struct ArtistResponse: Codable{
    let result : ArtisResults
    
    enum CodingKeys: String, CodingKey {
        case result = "results"
    }
}

struct ArtisResults: Codable {
    var artistMatches: ArtisMatches
   
    enum CodingKeys: String, CodingKey {
        case artistMatches = "artistmatches"
    }
}

struct ArtisMatches: Codable {
    let matches : [Artist]?
    
    enum CodingKeys: String, CodingKey {
        case matches = "artist"
    }
}

struct Artist: Codable {
     let title: String
     let name: String
     let image: [MusicImage]
    
    enum CodingKeys: String, CodingKey {
        case title = "name"
        case name = "url"
        case image = "image"
    }
}
