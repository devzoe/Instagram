//
//  ProfilesUserInfoDataManager.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/11.
//

import Alamofire

class ProfilesUserInfoDataManager{
    func getProfileInfo(delegate: SettingViewController) {
        var url = "\(Constant.BASE_URL)/profiles/userInfo/"
        url += String(UserDefaults.standard.integer(forKey: "UserIdx"))
        let token = UserDefaults.standard.string(forKey: "LoginUserIdentifier") ?? "none"
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":token])
            .validate()
            .responseDecodable(of: ProfilesUserInfoResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.result {
                        delegate.didSuccessProfileUserInfo(result: result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2003: delegate.failedToRequest(message: "권한이 없는 유저의 접근입니다.")
                        case 2070: delegate.failedToRequest(message: "유저가 확인되지 않습니다.")
                        case 4000: delegate.failedToRequest(message: "데이터베이스 연결에 실패하였습니다.")
                            
                        default: delegate.failedToRequest(message: "다시 입력해주세요.")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    func setProfileInfo(_ parameters: UserInfoRequest,delegate: PrivacyViewController) {
        var url = "\(Constant.BASE_URL)/profiles/userInfo/"
        //내 유저 idx
        let userIdx = UserDefaults.standard.integer(forKey: "UserIdx")
        url += String(userIdx)
        print(url)
        let token = UserDefaults.standard.string(forKey: "LoginUserIdentifier") ?? "none"
        print("My Token : ", token)
        
        AF.request(url, method: .patch, parameters: parameters, encoder : JSONParameterEncoder(), headers: ["X-ACCESS-TOKEN":token])
            .validate()
            .responseDecodable(of: UserInfoResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didUpdateUserInfo()
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2003: delegate.failedToRequest(message: "권한이 없는 유저의 접근입니다.")
                        case 2070: delegate.failedToRequest(message: "유저가 확인되지 않습니다.")
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
 
