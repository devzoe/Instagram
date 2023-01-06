//
//  PostResponse.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/06.
//

import Foundation

// MARK: - PostResponse
struct PostResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
