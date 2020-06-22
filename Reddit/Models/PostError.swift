//
//  PostError.swift
//  Reddit
//
//  Created by Mathias on 6/17/20.
//  Copyright © 2020 Mathias Chevez. All rights reserved.
//

import Foundation

enum PostError: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case thrownImageError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The Server failed to reach the necessary URL"
        case .thrownError(let error):
            return "There was an error: \(error)"
        case .thrownImageError(let error):
            return "There was an error with an image: \(error)"
        case .noData:
            return "There was no data found"
        case .unableToDecode:
            return "There was an error when trying to load the data"
        }
    }
}
