//
//  LogOutResponse.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/11.
//

import Foundation

// MARK: - LogOutResponse
struct LogOutResponse : Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
