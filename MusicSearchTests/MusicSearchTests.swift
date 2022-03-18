//
//  MusicSearchTests.swift
//  MusicSearchTests
//
//  Created by kumaresh shrivastava on 16/03/2022.
//

import XCTest
@testable import MusicSearch

class MusicSearchTests: XCTestCase,PayLoadFormat {
    
    var mockNetworkManager:MockNetworkManager!
    var apiModule:APIModuleProtocol!
    var musicViewModel: MusicViewModel!
    
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager(type: .album)
        apiModule = APIModule()
    }
    
    override func tearDown() {
        mockNetworkManager = nil
        apiModule = nil
        musicViewModel = nil
        super.tearDown()
    }
    
    //MARK: - Test ApiPayload
    /**
       - Test HTTPSPayload - URL creation for
         ALBUM ,
         ARTIST
         TRACK
     */
    func test_format_payload_type_album_url_formation_correctness() {
        
        let apiModule = APIModule(searchType: .album, payloadType: .requestMethodGET, searchText: "sonu nigam")
        let payload = HTTPSPayload(url: .musicUrl,apiModule: apiModule)
        
        XCTAssertEqual(payload.url?.absoluteString, "https://ws.audioscrobbler.com/2.0?method=album.search&album=sonu%20nigam&api_key=cc5ec0503a814608415d9992cabb72a4&format=json")
    }
    
    func test_format_payload_type_artist_url_formation_correctness() {
        
        let apiModule = APIModule(searchType: .artist, payloadType: .requestMethodGET, searchText: "sonu nigam")
        let payload = HTTPSPayload(url: .musicUrl,apiModule: apiModule)
        
        XCTAssertEqual(payload.url?.absoluteString, "https://ws.audioscrobbler.com/2.0?method=artist.search&artist=sonu%20nigam&api_key=cc5ec0503a814608415d9992cabb72a4&format=json")
    }
    
    func test_format_payload_type_track_url_formation_correctness() {
        
        let apiModule = APIModule(searchType: .track, payloadType: .requestMethodGET, searchText: "sonu nigam")
        let payload = HTTPSPayload(url: .musicUrl,apiModule: apiModule)
        
        XCTAssertEqual(payload.url?.absoluteString, "https://ws.audioscrobbler.com/2.0?method=track.search&track=sonu%20nigam&api_key=cc5ec0503a814608415d9992cabb72a4&format=json")
    }
    
    //MARK: - Mock NetworkManager
    /**
        Mock test of Network manager album api resposne, Artist api resposne and Track resposne api
     */
    
    func test_mock_networkmanager_album_api_jsondecoder_success() {
        
        mockNetworkManager = MockNetworkManager(type: .album)
        
        let apiModule = APIModule(searchType: .artist, payloadType: .requestMethodGET, searchText: "sonu nigam")
        let payload = formatGetPayload(url: .musicUrl, module: apiModule)
        
        mockNetworkManager.getAlbumsInfo(payload: payload!) { result in
            switch result {
            case .success(let data):
               XCTAssertNotNil(data)
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
    }
    
    func test_mock_networkmanager_artist_api_jsondecoder_success() {
        
        mockNetworkManager = MockNetworkManager(type: .artist)
        
        let apiModule = APIModule(searchType: .artist, payloadType: .requestMethodGET, searchText: "sonu nigam")
        let payload = formatGetPayload(url: .musicUrl, module: apiModule)
        
        mockNetworkManager.getArtistInfo(payload: payload!) { result in
            switch result {
            case .success(let data):
               XCTAssertNotNil(data)
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
    }
    
    func test_mock_networkmanager_track_api_jsondecoder_success() {
        
        mockNetworkManager = MockNetworkManager(type: .track)
        
        let apiModule = APIModule(searchType: .track, payloadType: .requestMethodGET, searchText: "sonu nigam")
        let payload = formatGetPayload(url: .musicUrl, module: apiModule)
        
        mockNetworkManager.getTrackInfo(payload: payload!) { result in
            switch result {
            case .success(let data):
               XCTAssertNotNil(data)
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
    }
        
    func test_mock_networkmanager_track_api_jsondecoder_response_json_data_empty() {
        
        mockNetworkManager = MockNetworkManager(false, withMockData: "")
        
        let apiModule = APIModule(searchType: .track, payloadType: .requestMethodGET, searchText: "sonu nigam")
        let payload = formatGetPayload(url: .musicUrl, module: apiModule)
        
        mockNetworkManager.getTrackInfo(payload: payload!) { result in
            switch result {
            case .success(let data):
              XCTAssertNil(data)
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, HandledError.noDataFound.localizedDescription)
            }
        }
    }
    
    func test_mock_networkmanager_track_api_jsondecoder_response_json_data_invalid() {
        
        mockNetworkManager = MockNetworkManager(false, withMockData: "[]")
        
        let apiModule = APIModule(searchType: .track, payloadType: .requestMethodGET, searchText: "sonu nigam")
        let payload = formatGetPayload(url: .musicUrl, module: apiModule)
        
        mockNetworkManager.getTrackInfo(payload: payload!) { result in
            switch result {
            case .success(let data):
              XCTAssertNil(data)
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, HandledError.inValidData.localizedDescription)
            }
        }
    }
    
    /**
     - Test to verify prepare Request
     */
    
    func test_validate_prepare_request(){
        
        let nm:NetworkManager = NetworkManager()
        let apiModule = APIModule(searchType: .artist, payloadType: .requestMethodGET, searchText: "sonu nigam")
        let payload = formatGetPayload(url: .musicUrl, module: apiModule)
        let (urlRequest,error) = nm.validateAndPrepareRequest(withPayload: payload)
        
        XCTAssertNotNil(urlRequest)
        XCTAssertNil(error)
    }
    
    //MARK: - Music View Model
    /**
        Test Music View model using mock network manager api response and test the Combine publisher and sink
     */
    
    

}
