//
//  FollowDataManager.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/10.
//

import Foundation
import Alamofire

class FollowDataManager {
    func gotFollower(userIdx: Int, delegate: FollowTabViewController) {
        var url = "\(Constant.BASE_URL)/"
        url += String(userIdx) + "/followers"

        let token = UserDefaults.standard.string(forKey: "LoginUserIdentifier") ?? "none"

        AF.request(url, method: .get, parameters: nil, encoding : JSONEncoding.default, headers: ["X-ACCESS-TOKEN":token])
            .validate()
            .responseDecodable(of: FollowerResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.result {
                        delegate.didGetFollower(result: result)
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
    func gotFollowerInTable(userIdx : Int, delegate: FollowerViewController) {
        var url = "\(Constant.BASE_URL)/"
        url += String(userIdx) + "/followers"

        let token = UserDefaults.standard.string(forKey: "LoginUserIdentifier") ?? "none"
        
        AF.request(url, method: .get, parameters: nil, encoding : JSONEncoding.default, headers: ["X-ACCESS-TOKEN":token])
            .validate()
            .responseDecodable(of: FollowerResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.result {
                        delegate.didGetFollower(result: result)
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
    func gotFollowing(userIdx : Int, delegate: FollowTabViewController) {
        var url = "\(Constant.BASE_URL)/"
        url += String(userIdx) + "/followings"
       
        let token = UserDefaults.standard.string(forKey: "LoginUserIdentifier") ?? "none"
        
        AF.request(url, method: .get, parameters: nil, encoding : JSONEncoding.default, headers: ["X-ACCESS-TOKEN":token])
            .validate()
            .responseDecodable(of: FollowingResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.result {
                        delegate.didGetFollowing(result: result)
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
    func gotFollowingInTable(userIdx : Int, delegate: FollowingViewController) {
        var url = "\(Constant.BASE_URL)/"
        url += String(userIdx) + "/followings"

        let token = UserDefaults.standard.string(forKey: "LoginUserIdentifier") ?? "none"
        
        AF.request(url, method: .get, parameters: nil, encoding : JSONEncoding.default, headers: ["X-ACCESS-TOKEN":token])
            .validate()
            .responseDecodable(of: FollowingResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.result {
                        delegate.didGetFollowing(result: result)
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
