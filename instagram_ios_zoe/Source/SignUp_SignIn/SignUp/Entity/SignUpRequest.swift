//
//  SignUpRequest.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/03.
//

struct SignUpRequest: Encodable {
    var userId : String
    var password: String
    var name: String
    var phone: String
    var email: String
    var birth: String
    var contract1: String
    var contract2: String
    var contract3: String
}
