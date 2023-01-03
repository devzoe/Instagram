//
//  SignUpDataManager.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/03.
//

import Alamofire

class SignUpDataManager {
    
    func postSignUp(_ parameters: SignUpRequest, delegate: FinalViewController) {
        AF.request("\(Constant.BASE_URL)/users", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: SignUpResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.result {
                        delegate.didSuccessSignUp(result)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2015: delegate.failedToRequest(message: "이메일을 입력해주세요.")
                        case 2013: delegate.failedToRequest(message: "휴대폰 번호를 입력해주세요.")
                        case 2010: delegate.failedToRequest(message: "유저 아이디 깞을 입력해주세요.")
                        case 2012: delegate.failedToRequest(message: "비밀번호 값을 입력해주세요.")
                        case 2021: delegate.failedToRequest(message: "필수 약관에 동의해주세요.")
                        case 2016: delegate.failedToRequest(message: "이메일 형식을 확인해주세요.")
                        case 2017: delegate.failedToRequest(message: "휴대폰 번호 형식을 확인해주세요.")
                        case 2018: delegate.failedToRequest(message: "중복된 이메일입니다.")
                        case 2019: delegate.failedToRequest(message: "중복된 휴대폰 번호 입니다.")
                        case 2020: delegate.failedToRequest(message: "중복된 사용자 이름입니다.")
                        case 2023: delegate.failedToRequest(message: "생년월일을 입력해주세요.")
                        case 2024: delegate.failedToRequest(message: "가입에 실패했습니다.")
                        case 4000: delegate.failedToRequest(message: "데이터베이스 연결에 실패했습니다.")
                        case 4011: delegate.failedToRequest(message: "비밀번호 암호화에 실해했습니다.")
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
