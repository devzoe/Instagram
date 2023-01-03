//
//  FeedResonse.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import Foundation

// MARK: - FeedResponse
struct FeedResponse : Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [FeedResult]?
}

// MARK: - FeedResult
struct FeedResult : Decodable {
    var postIdx: Int
    var content: String
    var userIdx: Int
    var userId: String
    var profileImgUrl: String?
    var postLikeCount: Int
    var updateAt: String
    var postImgRes: [PostImages]
}

// MARK: - PostImages
struct PostImages : Decodable{
    var postImgIdx: Int
    var postImgUrl: String
}
