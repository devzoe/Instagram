//
//  RecommendPostResponse.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/11.
//

import Foundation

// MARK: - RecommendPostResponse
struct RecommendPostResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [RecommendPostResult]?
}

// MARK: - RecommendPostResult
struct RecommendPostResult: Decodable {
    let postIdx : Int
    let postImg : String
}
