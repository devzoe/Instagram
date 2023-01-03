//
//  SignUpResponse.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/03.
//

struct SignUpResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: SignUpResult?
}

struct SignUpResult: Decodable {
    var userIdx: Int
    var jwt: String
}
