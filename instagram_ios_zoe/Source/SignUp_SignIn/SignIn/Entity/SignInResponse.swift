//
//  SignInResponse.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

struct SignInResponse: Decodable {
    var code: Int
    var message: String
    var isSuccess: Bool
    var result: SignInResult?
}

struct SignInResult: Decodable {
    var token: String
    var userInfoIdx: Int
}
