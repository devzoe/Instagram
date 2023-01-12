//
//  EditProfileDataManager.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/07.
//

import Alamofire

class EditProfileDataManager {
    func editProfileData(_ parameters: EditProfileRequest, delegate: ReadProfileEditViewController) {
        var url = "\(Constant.BASE_URL)/profiles/edit/"
        //내 유저 idx
        let userIdx = UserDefaults.standard.integer(forKey: "UserIdx")
        url += String(userIdx)
        
        
        let token = UserDefaults.standard.string(forKey: "LoginUserIdentifier") ?? "none"
        print("My Token : ", token)
        
        print("final profile : ", parameters.profileImage)
        AF.request(url, method: .patch, parameters: parameters, encoder: JSONParameterEncoder(), headers: ["X-ACCESS-TOKEN":token])
            .validate()
            .responseDecodable(of: EditProfileResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didUpdateProfile(result: response)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2003: delegate.failedToRequest(message: "권한 없는 유저의 접근입니다.")
                        case 2070: delegate.failedToRequest(message: "유저가 확인되지 않습니다.")
                        case 2080: delegate.failedToRequest(message: "중복된 사용자 이름입니다.")
                        case 4000: delegate.failedToRequest(message: "DB 오류")
                        default: delegate.failedToRequest(message: "다시 입력해주세요.")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
