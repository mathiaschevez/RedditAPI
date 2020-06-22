//
//  Post.swift
//  Reddit
//
//  Created by Mathias on 6/17/20.
//  Copyright © 2020 Mathias Chevez. All rights reserved.
//

import Foundation

struct TopLevelDictionary: Decodable {
    let data: SecondLevelDictionary
}

struct SecondLevelDictionary: Decodable {
    let children: [ThirdLevelObject]
}

struct ThirdLevelObject: Decodable {
    let data: Post
}

struct Post: Decodable {
    let title: String
    let thumbnail: URL?
    let ups: Int
}
