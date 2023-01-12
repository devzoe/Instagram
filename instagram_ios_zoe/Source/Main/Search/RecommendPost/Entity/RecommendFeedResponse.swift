//
//  RecommendFeedResponse.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/12.
//

import Foundation

// MARK: - RecommendFeedResponse
struct RecommendFeedResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [RecommendFeedResult]?
}

// MARK: - RecommendPostResult
struct RecommendFeedResult: Decodable {
    let postIdx : Int
    let content : String
    let userIdx : Int
    let userId : String
    let profileImgUrl : String?
    let postLikeCount : Int
    let commentCount : Int
    let updateAt : String
    let postImgRes : [PostImgRes]
}

struct PostImgRes : Decodable {
    let postImgIdx : Int
    let postImgUrl : String
}
