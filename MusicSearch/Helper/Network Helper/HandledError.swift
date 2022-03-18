//
//  HandledError.swift
//  MusicSearch
//
//  Created by kumaresh shrivastava on 16/03/2022.
//

import Foundation

enum HandledError: Error {
    case invalidURL
    case responseError
    case noDataFound
    case inValidData
    case unknown
    case invalidRequestHeader
    case invalidRequest
    case invalidPayload
}


extension HandledError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .invalidPayload:
            return NSLocalizedString("Invalid Payload", comment: "Invalid Payload")
        case .responseError:
            return NSLocalizedString("Unexpected status code", comment: "Invalid response")
        case .noDataFound:
            return NSLocalizedString("No data found", comment: "noDataFound error")
        case .invalidRequestHeader:
            return NSLocalizedString("InvalidRequestHeader", comment: "InvalidRequestHeader")
        case .invalidRequest:
            return NSLocalizedString("InvalidRequest", comment: "InvalidRequest")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        case .inValidData:
            return NSLocalizedString("In valid data", comment: "inValidData error")
        }
    }
}

