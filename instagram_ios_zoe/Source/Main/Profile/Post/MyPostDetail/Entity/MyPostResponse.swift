//
//  ProfileResponse.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/04.
//

import Foundation


// MARK: - MyPostResponse
struct MyPostResponse : Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: MyPostResult?
}

// MARK: - MyPostResult
struct MyPostResult : Decodable {
    var postIdx: Int
    var content: String
    var userIdx: Int
    var userId: String
    var profileImgUrl: String?
    var postLikeCount: Int
    var updateAt: String
    var postImgRes: [MyPostImages]
    var postContentRes: [MyPostContents?]
}

// MARK: - MyPostImages
struct MyPostImages : Decodable{
    var postImgIdx: Int
    var postImgUrl: String
}

// MARK: - MyPostContents
struct MyPostContents : Decodable{
    var postCommentIdx: Int
    var reply: String
    var depth: Int
    var userIdx: Int
    var commentLikeCount : Int
    var userId: String
    var profileImg: String?
    var commentIdxA: Int
}


