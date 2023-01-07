//
//  SearchResponse.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/07.
//

import Foundation

struct SearchResponse : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : [SearchResult]?
}
struct SearchResult : Decodable {
    var userIdx : Int
    var name : String
    var detail : String?
    var img : String?
    var cnt : Int
}
