//
//  FollowingResponse.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/10.
//

import Foundation

struct FollowingResponse : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : [FollowingResult]?
}

struct FollowingResult : Decodable {
    var userIdx : Int
    var name : String?
    var profileImg: String?
    var id : String
    var status : String
    var followYn : String
}
