//
//  RecentSearchesDataManager.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/07.
//

import Alamofire
class RecentSearchesDataManager {
    func getRecentSearchesData(delegate: SearchViewController) {
        var url = "\(Constant.BASE_URL)/searches/"
        let userIdx = UserDefaults.standard.integer(forKey: "UserIdx")
        url += String(userIdx)
        print("My url : ", url)
        let token = UserDefaults.standard.string(forKey: "LoginUserIdentifier") ?? "none"
        print("My Token : ", token)
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X-ACCESS-TOKEN":token])
            .validate()
            .responseDecodable(of: RecentSearchesResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.result {
                        delegate.didSuccessRecentSearches(result: response)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2003: delegate.failedToRequest(message: "권한 없는 유저의 접근입니다.")
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
    
    func deleteWord(_ word: String, delegate: SearchViewController) {
        var url = "\(Constant.BASE_URL)/searches/"
        //내 유저 idx
        let userIdx = UserDefaults.standard.integer(forKey: "UserIdx")
        url += String(userIdx)
        url += "?word=" + word
        print("url: ", url)
        
        let token = UserDefaults.standard.string(forKey: "LoginUserIdentifier") ?? "none"
        print("My Token : ", token)
        
        AF.request(url, method: .delete, parameters: nil, encoding:JSONEncoding.default, headers: ["X-ACCESS-TOKEN":token])
            .validate()
            .responseDecodable(of: DeleteWordResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didDeleteWord()
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
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
