//
//  DeleteWordResponse.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/12.
//

import Foundation

// MARK: - RecommendPostResponse
struct DeleteWordResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
