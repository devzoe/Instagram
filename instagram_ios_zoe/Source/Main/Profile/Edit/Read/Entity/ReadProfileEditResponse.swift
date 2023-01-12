//
//  ReadProfileEditResponse.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/07.
//

import Foundation

// MARK: - ReadProfileEditResponse
struct ReadProfileEditResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: ReadProfileEditResult?
}

// MARK: - ReadProfileEditresult
struct ReadProfileEditResult: Decodable {
    var userIdx: Int
    var userId : String
    var name: String?
    var introduction, profileImg, website: String?
}
