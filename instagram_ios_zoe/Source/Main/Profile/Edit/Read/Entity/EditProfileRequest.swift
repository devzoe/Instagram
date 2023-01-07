//
//  EditProfileRequest.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/07.
//

import Foundation

struct EditProfileRequest : Encodable {
    var userIdx : Int
    var userId : String
    var name : String
    var profileImage : String?
    var website : String?
    var introduction : String?
}
