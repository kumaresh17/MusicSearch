//
//  MockNetworkManager.swift
//  MusicSearchTests
//
//  Created by kumaresh shrivastava on 16/03/2022.
//

import Foundation
@testable import MusicSearch

final class MockNetworkManager {
    var shouldReturnError = false
    var getApiCalled = true
    
    let netWorkManager = NetworkManager()
    var mockURLResponse:HTTPURLResponse?
    var mockResponse:String?
    
    enum MockServiceError:Error {
        case APIERROR
    }

    func reset(){
        shouldReturnError = false
        getApiCalled = false
    }
    
    /// This convinience init is used for mocking for get Music (songs, artist and album) list Apis response
    convenience init(type:MusicType) {

        switch type {
        case .album:
            self.init(false, withMockData:"{\"results\":{\"opensearch:Query\":{\"#text\":\"\",\"role\":\"request\",\"searchTerms\":\"Sonu%20nigam\",\"startPage\":\"1\"},\"opensearch:totalResults\":\"24735\",\"opensearch:startIndex\":\"0\",\"opensearch:itemsPerPage\":\"1\",\"albummatches\":{\"album\":[{\"name\":\"Sonu Nigam: Best Of Me\",\"artist\":\"Sonu Nigam\",\"url\":\"https://www.last.fm/music/Sonu+Nigam/Sonu+Nigam:+Best+Of+Me\",\"image\":[{\"#text\":\"https://lastfm.freetls.fastly.net/i/u/34s/2a96cbd8b46e442fc41c2b86b821562f.png\",\"size\":\"small\"},{\"#text\":\"https://lastfm.freetls.fastly.net/i/u/64s/2a96cbd8b46e442fc41c2b86b821562f.png\",\"size\":\"medium\"},{\"#text\":\"https://lastfm.freetls.fastly.net/i/u/174s/2a96cbd8b46e442fc41c2b86b821562f.png\",\"size\":\"large\"},{\"#text\":\"https://lastfm.freetls.fastly.net/i/u/300x300/2a96cbd8b46e442fc41c2b86b821562f.png\",\"size\":\"extralarge\"}],\"streamable\":\"0\",\"mbid\":\"\"}]},\"@attr\":{\"for\":\"Sonu%20nigam\"}}}", mockResposne: HTTPURLResponse(url:URL.init(string:  "https://foo.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!)
            
        case .artist:
            self.init(false, withMockData:"{\"results\":{\"opensearch:Query\":{\"#text\":\"\",\"role\":\"request\",\"searchTerms\":\"Sonu%20nigam\",\"startPage\":\"1\"},\"opensearch:totalResults\":\"10688\",\"opensearch:startIndex\":\"0\",\"opensearch:itemsPerPage\":\"1\",\"artistmatches\":{\"artist\":[{\"name\":\"Sonu Nigam\",\"listeners\":\"92828\",\"mbid\":\"93622908-0806-4173-94c1-9e42597af011\",\"url\":\"https://www.last.fm/music/Sonu+Nigam\",\"streamable\":\"0\",\"image\":[{\"#text\":\"https://lastfm.freetls.fastly.net/i/u/34s/2a96cbd8b46e442fc41c2b86b821562f.png\",\"size\":\"small\"},{\"#text\":\"https://lastfm.freetls.fastly.net/i/u/64s/2a96cbd8b46e442fc41c2b86b821562f.png\",\"size\":\"medium\"},{\"#text\":\"https://lastfm.freetls.fastly.net/i/u/174s/2a96cbd8b46e442fc41c2b86b821562f.png\",\"size\":\"large\"},{\"#text\":\"https://lastfm.freetls.fastly.net/i/u/300x300/2a96cbd8b46e442fc41c2b86b821562f.png\",\"size\":\"extralarge\"},{\"#text\":\"https://lastfm.freetls.fastly.net/i/u/300x300/2a96cbd8b46e442fc41c2b86b821562f.png\",\"size\":\"mega\"}]}]},\"@attr\":{\"for\":\"Sonu%20nigam\"}}}", mockResposne: HTTPURLResponse(url:URL.init(string:  "https://foo.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!)
            
        case .track:
            self.init(false, withMockData:"{\"results\":{\"opensearch:Query\":{\"#text\":\"\",\"role\":\"request\",\"startPage\":\"1\"},\"opensearch:totalResults\":\"39926\",\"opensearch:startIndex\":\"0\",\"opensearch:itemsPerPage\":\"1\",\"trackmatches\":{\"track\":[{\"name\":\"Main Agar Kahoon\",\"artist\":\"Sonu Nigam\",\"url\":\"https://www.last.fm/music/Sonu+Nigam/_/Main+Agar+Kahoon\",\"streamable\":\"FIXME\",\"listeners\":\"8567\",\"image\":[{\"#text\":\"https://lastfm.freetls.fastly.net/i/u/34s/2a96cbd8b46e442fc41c2b86b821562f.png\",\"size\":\"small\"},{\"#text\":\"https://lastfm.freetls.fastly.net/i/u/64s/2a96cbd8b46e442fc41c2b86b821562f.png\",\"size\":\"medium\"},{\"#text\":\"https://lastfm.freetls.fastly.net/i/u/174s/2a96cbd8b46e442fc41c2b86b821562f.png\",\"size\":\"large\"},{\"#text\":\"https://lastfm.freetls.fastly.net/i/u/300x300/2a96cbd8b46e442fc41c2b86b821562f.png\",\"size\":\"extralarge\"}],\"mbid\":\"\"}]},\"@attr\":{}}}", mockResposne: HTTPURLResponse(url:URL.init(string:  "https://foo.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!)
        }
        
    }
    
    init(_ shouldReturnError:Bool,withMockData:String,mockResposne:HTTPURLResponse = HTTPURLResponse(url:URL.init(string:  "https://foo.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!) {
        self.shouldReturnError = shouldReturnError
        self.mockResponse = withMockData
        self.mockURLResponse = mockResposne
    }
}


extension MockNetworkManager: NetworkManagerProtocol {
    
    func getAlbumsInfo(payload: HTTPSPayloadProtocol, completion: @escaping (Result<AlbumResponse, Error>) -> Void) {
        self.sendRequest(payLoad:payload,completion:completion)
    }
    
    func getTrackInfo(payload: HTTPSPayloadProtocol, completion: @escaping (Result<TrackResponse, Error>) -> Void) {
        self.sendRequest(payLoad:payload,completion:completion)
    }
    
    func getArtistInfo(payload: HTTPSPayloadProtocol, completion: @escaping (Result<ArtistResponse, Error>) -> Void) {
        self.sendRequest(payLoad:payload,completion:completion)
    }
    
    func sendRequest<T:Codable>(payLoad:HTTPSPayloadProtocol?,completion: @escaping (Result<T,Error>) -> Void) {

        getApiCalled = true
        let (urlRequest,error) = netWorkManager.validateAndPrepareRequest(withPayload: payLoad)
        if error != nil  {
            completion(.failure(error!))
            return
        }
        guard urlRequest != nil else {
            completion(.failure(HandledError.invalidRequestHeader))
            return
        }

        if shouldReturnError == true {
            completion(.failure(MockServiceError.APIERROR))
        } else {
            let data = Data(self.mockResponse!.utf8)
            netWorkManager.jsonDecoder(data: data, response: mockURLResponse,completion: completion)
        }
    }

    
}
