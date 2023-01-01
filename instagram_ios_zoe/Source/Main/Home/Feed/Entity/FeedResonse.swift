//
//  FeedResonse.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import Foundation

struct FeedResponse  {
    var feedList : [Feed]
}

struct Feed {
    var profileImageName : String
    var id : String
    var feedImageName : String
    var feedText : String
}
