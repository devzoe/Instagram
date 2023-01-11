//
//  UserInfoRequest.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/12.
//

import Foundation

struct UserInfoRequest : Encodable {
    var userIdx : Int
    var email : String?
    var phone : String?
    var sex : String?
    var birth : String?
}
