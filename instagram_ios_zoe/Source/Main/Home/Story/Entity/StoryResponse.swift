//
//  StoryResponse.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import Foundation

struct StoryResponse  {
    var storyList : [Story]
}

struct Story {
    var profileImageName : String // 스토리를 올린 사람의 프로필 이미지
    var id : String // 스토리를 올린 사람의 id
}
