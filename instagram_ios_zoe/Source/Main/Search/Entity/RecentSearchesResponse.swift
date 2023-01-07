//
//  RecentSearchesResponse.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/07.
//

import Foundation

struct RecentSearchesResponse : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : [RecentSearchesResult]?
}

struct RecentSearchesResult : Decodable {
    var searchWord : String
    var status : String
}
