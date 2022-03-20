//
//  ApiPayload.swift
//  MusicSearch
//
//  Created by kumaresh shrivastava on 16/03/2022.
//

import Foundation

protocol PayLoadFormat {
    func formatGetPayload(url: HTTPSUrl,module: APIModuleProtocol) -> HTTPSPayloadProtocol?
}

extension PayLoadFormat {
    func formatGetPayload(url: HTTPSUrl,module: APIModuleProtocol) -> HTTPSPayloadProtocol? {
        guard let _ = module.payloadType else {return nil}
        var payload = HTTPSPayload(url: url,apiModule: module)
        payload.headers = Dictionary<String, String>()
        payload.addHeader(name: HTTPSHeaderType.contentType.rawValue, value: HTTPSMimeType.applicationJSON.rawValue)
        return payload
    }
}

protocol HTTPSPayloadProtocol {
    var type: HTTPSPayloadType? { get }
    var headers: Dictionary<String, String>? { get set }
    var url: URL? {get}
}
/// Payload creation
struct HTTPSPayload: HTTPSPayloadProtocol {
    var type: HTTPSPayloadType?
    var headers: Dictionary<String, String>?
    var url: URL?
    let apiKey = "cc5ec0503a814608415d9992cabb72a4"
    init(url: HTTPSUrl, apiModule: APIModuleProtocol) {
        self.type = apiModule.payloadType
        var components = URLComponents()
            components.scheme = "https"
            components.host = url.rawValue
            components.path = "/2.0"
            components.queryItems = [
                URLQueryItem(name: "method", value: apiModule.searchType.getSearchType()),
                URLQueryItem(name: apiModule.searchType.getType(), value: apiModule.searchText),
                URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "format", value: "json")
            ]
        self.url = components.url
    }
    fileprivate mutating func addHeader(name: String, value: String) {
        headers?[name] = value
    }
}
protocol APIModuleProtocol {
    var searchType: MusicType { get set }
    var payloadType: HTTPSPayloadType? { get set }
    var searchText:String? { get set }
}


struct APIModule:APIModuleProtocol {
    var searchType: MusicType = .album
    var payloadType: HTTPSPayloadType?
    var searchText:String?
}

enum MusicType: String {
  case album = "album"
  case track = "track"
  case artist = "artist"
    
    func getType() -> String {
        switch self{
        case .album: return MusicType.album.rawValue
        case .track: return MusicType.track.rawValue
        case .artist: return MusicType.artist.rawValue
        }
    }
    
    func getSearchType() -> String {
        switch self{
        case .album: return SearchType.album.rawValue
        case .track: return SearchType.track.rawValue
        case .artist: return SearchType.artist.rawValue
        }
    }
}

enum SearchType: String {
  case album = "album.search"
  case track = "track.search"
  case artist = "artist.search"
}

enum HTTPSMimeType: String {
    case applicationJSON = "application/json; charset=utf-8"
}
enum HTTPSHeaderType: String{
    case contentType    = "Content-Type"
}

enum HTTPSPayloadType{
    case requestMethodGET
    func httpMethod() -> String {
        switch self{
        case .requestMethodGET: return HTTPSMethod.get.rawValue
        }
    }
}
enum HTTPSMethod: String {
    case get
}


enum HTTPSUrl: String {
    case musicUrl = "ws.audioscrobbler.com"
}
