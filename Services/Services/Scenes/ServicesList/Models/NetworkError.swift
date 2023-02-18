//
//  NetworkError.swift
//  Services
//
//  Created by Dmitry Maslennikov on 18.02.2023.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case badURL
    case dataFailed
    case decodeFailed
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "Bad URL"
        case .dataFailed:
            return "Data Failed"
        case .decodeFailed:
            return "Decode Failed"
        }
    }
}
