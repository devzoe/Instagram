//
//  LogOutDataManager.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/11.
//

import Alamofire

class LogOutDataManager {
    
    func logOut(_ parameters: LogOutRequest, delegate: SettingViewController) {
        var url = "\(Constant.BASE_URL)/users/"
        url += String(UserDefaults.standard.integer(forKey: "UserIdx"))
        url += "/logOut"
        let token = UserDefaults.standard.string(forKey: "LoginUserIdentifier") ?? "none"
        print(url)
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: ["X-ACCESS-TOKEN":token])
            .validate()
            .responseDecodable(of: LogOutResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess{
                        delegate.didSuccessLogOut(response)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2003: delegate.failedToRequest(message: "권한이 없는 유저의 접근입니다.")
                        case 2022: delegate.failedToRequest(message: "이메일 혹은 휴대폰번호를 입력해주세요.")
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
     
}

