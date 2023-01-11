//
//  UserInfoResponse.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/12.
//

import Foundation

// MARK: - UserInfoResponse
struct UserInfoResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    
}
