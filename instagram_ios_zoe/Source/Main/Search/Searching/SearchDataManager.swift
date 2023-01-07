//
//  SearchDataManager.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/07.
//

import Alamofire

class SearchingDataManager {
    func getAccountData(_ parameters: SearchRequest,delegate: SearchAccountViewController) {
        var url = "\(Constant.BASE_URL)/searches/"
        //내 유저 idx
        let userIdx = UserDefaults.standard.integer(forKey: "UserIdx")
        url += String(userIdx) + "/users?"
        url += "word=" + parameters.word
        print(url)
        let token = UserDefaults.standard.string(forKey: "LoginUserIdentifier") ?? "none"
        print("My Token : ", token)
        
        AF.request(url, method: .get, parameters: nil, encoding : JSONEncoding.default, headers: ["X-ACCESS-TOKEN":token])
            .validate()
            .responseDecodable(of: SearchResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.result {
                        delegate.didSuccessSearch(result: result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2091: delegate.failedToRequest(message: "상태값을 확인해주세요.")
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
