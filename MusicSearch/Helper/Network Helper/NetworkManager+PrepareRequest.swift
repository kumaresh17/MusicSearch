//
//  NetworkManager+PrepareRequest.swift
//  MusicSearch
//
//  Created by kumaresh shrivastava on 16/03/2022.
//

import Foundation

/**
   -  Check and Prepare the request URL with the payload data
 */
extension NetworkManager {
    
    func validateAndPrepareRequest(withPayload payload:HTTPSPayloadProtocol?) -> (URLRequest?,HandledError?) {
        
        var urlRequest:URLRequest?
        guard let payload = payload else {
            return (nil,(HandledError.invalidPayload))
        }
        
        if let requestUrl =  payload.url {
            urlRequest = URLRequest(url: requestUrl)
            guard let headers = payload.headers else {
                return (nil,(HandledError.invalidRequestHeader))}
            
            guard var urlRequest = urlRequest else {
                return (nil,(HandledError.invalidRequest))}
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
            urlRequest.httpMethod = payload.type?.httpMethod()
            return (urlRequest,nil)
        } else {
            return (nil,(HandledError.invalidURL))
        }
    }
}

