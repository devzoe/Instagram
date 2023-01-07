//
//  CommentRequest.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/08.
//

import Foundation

struct CommentRequest : Encodable {
    var reply : String
    var depth : Int
    var commentAIdx : Int
}
