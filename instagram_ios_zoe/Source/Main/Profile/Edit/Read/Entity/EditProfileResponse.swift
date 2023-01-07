//
//  EditProfileResponse.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/07.
//

import Foundation

struct EditProfileResponse : Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
}
