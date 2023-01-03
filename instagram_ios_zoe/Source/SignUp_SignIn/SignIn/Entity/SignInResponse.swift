//
//  SignInResponse.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

struct SignInResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: SignInResult?
}

struct SignInResult: Decodable {
    var userIdx: Int
    var jwt: String

}
