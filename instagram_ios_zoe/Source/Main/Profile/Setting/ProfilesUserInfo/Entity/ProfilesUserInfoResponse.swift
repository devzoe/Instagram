//
//  ProfilesUserInfoResponse.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/11.
//

import Foundation

// MARK: - ProfilesUserInfoResponse
struct ProfilesUserInfoResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: ProfilesUserInfoResult?
}

// MARK: - ProfilesUserInfoResult
struct ProfilesUserInfoResult: Decodable {
    let userIdx: Int
    let email : String?
    let phone : String?
    let sex : String?
    let birth : String?
}
