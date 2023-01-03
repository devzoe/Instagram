//
//  SignInRequest.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

struct SignInRequest: Encodable {
    var email: String?
    var phone: String?
    var password: String
}
