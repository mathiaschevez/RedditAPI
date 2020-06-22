//
//  PostController.swift
//  Reddit
//
//  Created by Mathias on 6/17/20.
//  Copyright © 2020 Mathias Chevez. All rights reserved.
//

import Foundation
import UIKit

struct stringConstants {
    
    fileprivate static let baseURLString = "https://www.reddit.com"
    fileprivate static let rCompString = "r"
    fileprivate static let funnyCompString = "funny"
    fileprivate static let jsonExtensionString = "json"
}

class PostController {
    static func fetchPosts(completion: @escaping (Result<[Post], PostError>) -> Void) {
        
        guard let baseURL = URL(string: stringConstants.baseURLString) else {return completion(.failure(.invalidURL))}
        let rCompURL = baseURL.appendingPathComponent(stringConstants.rCompString)
        let funnyCompURL = rCompURL.appendingPathComponent(stringConstants.funnyCompString)
        let finalURL = funnyCompURL.appendingPathExtension(stringConstants.jsonExtensionString)
        
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            do {
                let topLevelDictionary = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                let secondLevelDict = topLevelDictionary.data
                let thirdLevelArray = secondLevelDict.children
                
                var postsPlaceHolderArray: [Post] = []
                
                for thirdLevelObject in thirdLevelArray {
                    let post = thirdLevelObject.data
                    postsPlaceHolderArray.append(post)
                }
                
                completion(.success(postsPlaceHolderArray))
                
            } catch {
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchThumbnailFor(post: Post, completion: @escaping (Result<UIImage, PostError>) -> Void) {
        guard let url = post.thumbnail else {return}
        print(url)
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownImageError(error)))
            }
            guard let data = data else {return completion(.failure(.noData))}
            
            guard let thumbnailImage = UIImage(data: data) else { return completion(.failure(.unableToDecode))}
            
            completion(.success(thumbnailImage))
            
        }.resume()
    }
}
