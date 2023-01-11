//
//  CloseAccountDataManager.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/12.
//

import Alamofire

class CloseAccountDataManager {
    func closeAccount(delegate: SettingViewController) {
        var url = "\(Constant.BASE_URL)/users/"
        url += String(UserDefaults.standard.integer(forKey: "UserIdx"))

        let token = UserDefaults.standard.string(forKey: "LoginUserIdentifier") ?? "none"
        print(url)
        AF.request(url, method: .patch, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":token])
            .validate()
            .responseDecodable(of: LogOutResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess{
                        delegate.didSuccessCloseAccount(response)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        
                        case 4013: delegate.failedToRequest(message: "회원 탈퇴에 실패하였습니다.")
                       
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
