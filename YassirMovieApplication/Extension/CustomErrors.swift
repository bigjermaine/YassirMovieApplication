//
//  CustomErrors.swift
//  YassirMovieApplication
//
//  Created by MacBook AIR on 23/06/2024.
//

import Foundation

enum NetworkError: Error {
    case decodingFailed
    case noInternetConnection
    // Add more error cases as needed
    var localizedDescription: String {
        switch self {
        case .decodingFailed:
            return NSLocalizedString("Failed to decode the response from the server.", comment: "")
        case .noInternetConnection:
            return NSLocalizedString("No internet connection available.", comment: "")
        }
    }
}


