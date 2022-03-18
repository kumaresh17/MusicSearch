//
//  NetworkManager+JsonDecoder.swift
//  MusicSearch
//
//  Created by kumaresh shrivastava on 16/03/2022.
//

import Foundation

/**
   - Check the resposne and data  and if all ok then decode the response data
 */

extension NetworkManager {

    func jsonDecoder<T:Codable>(data:Data?,response:URLResponse?,completion:@escaping (Result<T,Error>) -> Void) -> Void {
        
        guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
            completion(.failure(HandledError.responseError))
            return }
        guard let data = data, !data.isEmptyData() else {
            completion(.failure(HandledError.noDataFound))
            return }
        if data.isInValid()  {
            completion(.failure(HandledError.inValidData))
            return }
        
        var result: Result<T, Error>
        
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(T.self, from: data)
            result = .success(response)
        } catch let error {
            result = .failure(error)
        }
        completion(result)
    }
    
    
}

