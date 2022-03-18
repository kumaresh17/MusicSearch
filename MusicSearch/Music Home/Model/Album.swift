//
//  Album.swift
//  MusicSearch
//
//  Created by kumaresh shrivastava on 16/03/2022.
//
import Foundation

struct AlbumResponse: Codable{
    let albums : AlbumsResult

    enum CodingKeys: String, CodingKey {
        case albums = "results"
    }
}

struct AlbumsResult: Codable {
    var albumMatches: AlbumInfo

    enum CodingKeys: String, CodingKey {
        case albumMatches = "albummatches"
    }
}

struct AlbumInfo: Codable {
    var album: [Albums]?

    enum CodingKeys: String, CodingKey {
        case album = "album"
    }
}

struct Albums: Codable {
    let title: String
    let name: String
    let images: [MusicImage]

    enum CodingKeys: String, CodingKey {
        case title = "name"
        case name = "artist"
        case images = "image"
    }
}

struct MusicImage: Codable{
    let url: String
    let size: String

    enum CodingKeys: String, CodingKey{
        case url = "#text"
        case size
    }
}

protocol MusicResponseProtocol {
    var title: String? {get set}
    var name: String? {get set}
    var images: [MusicImage]? {get set}
}
struct MusicResponse: MusicResponseProtocol {
    var title: String?
    var name: String?
    var images: [MusicImage]?

}
