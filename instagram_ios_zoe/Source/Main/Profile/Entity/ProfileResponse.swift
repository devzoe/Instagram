//
//  ProfileResponse.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/04.
//

import Foundation

// MARK: - ProfileResponse
struct ProfileResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: ProfileResult?
}

// MARK: - Result
struct ProfileResult: Decodable {
    let userIdx: Int
    let userId, name: String
    let introduction, profileImg, website: String?
    let postCount, followerCount, followingCount: Int
    let profilePostImgs: [ProfilePostImg]?
}

// MARK: - ProfilePostImg
struct ProfilePostImg: Decodable {
    let postIdx: Int
    let postImgUrl: String
}