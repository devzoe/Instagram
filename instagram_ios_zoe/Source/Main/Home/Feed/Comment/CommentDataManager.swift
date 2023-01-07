//
//  CommentDataManager.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/08.
//

import Alamofire

class CommentDataManager {
    func postComment(_ postIdx: Int, _ parameters: CommentRequest, delegate : CommentViewController) {
        var url = "\(Constant.BASE_URL)/comments?"
        //내 유저 idx
        let userIdx = UserDefaults.standard.integer(forKey: "UserIdx")
        url += "userIdx=\(userIdx)&postIdx=\(postIdx)"
        
        print("My url : ", url)
        
        let token = UserDefaults.standard.string(forKey: "LoginUserIdentifier") ?? "none"
        print("My Token : ", token)

        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: ["X-ACCESS-TOKEN":token])
            .validate()
            .responseDecodable(of: PostResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess{
                        delegate.didSuccessComment()
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2003: delegate.failedToRequest(message: "권한 없는 유저의 접근입니다.")
                        case 2070: delegate.failedToRequest(message: "유저가 확인되지 않습니다.")
                        case 2085: delegate.failedToRequest(message: "댓글의 값이 없습니다.")
                        case 2071: delegate.failedToRequest(message: "게시물이 확인되지 않습니다.")
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
