//
//  FollowResponse.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/12.
//

import Foundation

struct FollowResponse : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
}
