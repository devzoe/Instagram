//
//  PostData.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/07.
//

class PostData {
    static let shared = PostData()
    var postResponse : MyPostResponse?
    // Create
    public func add(_ postResponse: MyPostResponse) {
        self.postResponse = postResponse
    }
    
}
