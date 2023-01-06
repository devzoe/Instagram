//
//  DeleteResponse.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/06.
//

import Foundation

// MARK: - DeletePostResponse
struct DeletePostResponse : Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
