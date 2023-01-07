//
//  CommentResponse.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/08.
//

import Foundation

struct CommentResponse : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
}
