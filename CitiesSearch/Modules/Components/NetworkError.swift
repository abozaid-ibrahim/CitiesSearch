//
//  APIClient.swift
//  SchipholApp
//
//  Created by abuzeid on 30.10.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//
import Foundation

enum NetworkError: LocalizedError {
    case badRequest
    case noData
    case failedToParseData
    var errorDescription: String? {
        switch self {
        case .failedToParseData:
            return "Technical Difficults, we can't fetch the data"
        default:
            return "Something went wrong"
        }
    }
}
