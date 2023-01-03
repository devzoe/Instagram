//
//  SignInDataManager.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import Alamofire

class SignInDataManager {
    
    func postSignIn(_ parameters: SignInRequest, delegate: SignInViewController) {
        AF.request("\(Constant.BASE_URL)/users/logIn", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: SignInResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.result {
                        delegate.didSuccessSignIn(result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2022: delegate.failedToRequest(message: "이메일 혹은 휴대폰 번호를 입력해주세요.")
                        case 2012: delegate.failedToRequest(message: "비밀번호 값을 입력해주세요.")
                        case 3014: delegate.failedToRequest(message: "없는 아이디거나 비밀번호가 틀렸습니다.")
                        case 3015: delegate.failedToRequest(message: "탈퇴 회원입니다.")
                        case 4012: delegate.failedToRequest(message: "비밀번호 복호화에 실패하였습니다.")
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
