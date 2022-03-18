//
//  NetworkManager.swift
//  MusicSearch
//
//  Created by kumaresh shrivastava on 16/03/2022.
//

import Foundation
import UIKit

/// Network status
enum ReachabilityStatus {
    case unknown
    case disconnected
    case connected
}

protocol NetworkServiceProtocol : AnyObject {
    var urlSession: URLSessionProtocol { get }
}

///  API manager class to handle the API calls
final class NetworkManager: NetworkServiceProtocol {
    /// URLSession used for query
    var urlSession: URLSessionProtocol
    /// Data Task
    private var task: URLSessionDataTask?
    // Reachability to check the internet
    private let reachabilityManager: NetworkReachabilityManager?
    private(set) var reachabilityStatus: ReachabilityStatus
    /**
     Init kit
     - Parameter urlSession: URLSession used for query
     */
    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
        self.reachabilityManager = NetworkReachabilityManager()
        self.reachabilityStatus = .unknown
        beginListeningNetworkReachability()
    }
    
    deinit {
        reachabilityManager?.stopListening()
    }
    
    /**
     Reachability
     
     - Start the reachability
     - To checek network status
     */
    private func beginListeningNetworkReachability() {
        reachabilityManager?.listener = { status in
            switch status {
            case .unknown: self.reachabilityStatus = .unknown
            case .notReachable:
                self.reachabilityStatus = .disconnected
                self.showErrorForNoNetwork()
            case .reachable(.ethernetOrWiFi), .reachable(.wwan): self.reachabilityStatus = .connected
            }
        }
        reachabilityManager?.startListening()
    }
    /**
     Show Alert message on no network connection
     */
    private func showErrorForNoNetwork()  {
        task?.suspend()
        DispatchQueue.main.async {
            AlertViewController.showAlert(withTitle: "Alert", message: "No Internet Connection")
        }
    }
    /// init Kit
     convenience init() {
        self.init(urlSession: URLSession.shared)
    }
    
    /**
      Send API Request
     **/
    private func sendRequest<T: Codable>(payload: HTTPSPayloadProtocol?, completion: @escaping (Result<T, Error>) -> Void)  {
        
        let (urlRequest,error) = self.validateAndPrepareRequest(withPayload: payload)
        if error != nil  {
            completion(.failure(error!))
            return
        }
        guard let urlRequest = urlRequest else {
            completion(.failure(HandledError.invalidRequestHeader))
            return
        }
        task = urlSession.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            self?.jsonDecoder(data: data ?? nil, response: response ?? nil, completion: completion)
        }
        task?.resume()
    }

}

/// APIManager Protocol
protocol NetworkManagerProtocol {
    func getAlbumsInfo(payload: HTTPSPayloadProtocol,completion: @escaping (Result<AlbumResponse, Error>) -> Void)
    func getTrackInfo(payload: HTTPSPayloadProtocol, completion: @escaping (Result<TrackResponse, Error>) -> Void)
    func getArtistInfo(payload: HTTPSPayloadProtocol, completion: @escaping (Result<ArtistResponse, Error>) -> Void)
}
/**
 Extension for APIManager
 */
extension NetworkManager: NetworkManagerProtocol {
    /**
     Retrieve the Albums
     - Parameter id:  Payload protocol, containing payload data
     - Parameter completion: Result of api call
     */
    func getAlbumsInfo(payload: HTTPSPayloadProtocol, completion: @escaping (Result<AlbumResponse, Error>) -> Void){
        sendRequest(payload: payload,completion: completion)
    }
    /**
     Retrieve the Songs
     - Parameter id:  Payload protocol, containing payload data
     - Parameter completion: Result of api call
     */
    func getTrackInfo(payload: HTTPSPayloadProtocol, completion: @escaping (Result<TrackResponse, Error>) -> Void){
        sendRequest(payload: payload,completion: completion)
    }
    /**
     Retrieve the Artists
     - Parameter id:  Payload protocol, containing payload data
     - Parameter completion: Result of api call
     */
    func getArtistInfo(payload: HTTPSPayloadProtocol, completion: @escaping (Result<ArtistResponse, Error>) -> Void){
        sendRequest(payload: payload,completion: completion)
    }

}
