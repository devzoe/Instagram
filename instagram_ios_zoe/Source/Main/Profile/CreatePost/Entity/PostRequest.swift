//
//  PostRequest.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/06.
//

import Foundation

struct PostRequest : Encodable{
    var content : String
    var postImgReqs : [PostImageReqs]
}

struct PostImageReqs : Encodable{
    var postImgUrl : String
}
