//
//  FinalViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import UIKit

class FinalViewController: BaseViewController {
    lazy var dataManager: SignUpDataManager = SignUpDataManager()
    
    var userInfo : SignUpRequest = SignUpRequest(userId: "", password: "", name: "", phone: "", email: "", birth: "", contract1: "", contract2: "", contract3: "")

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signUpButton.setCornerRadius(10)
        print(userInfo)
        self.idLabel.text = userInfo.userId
    }
    
    @IBAction func signUpButtonTouchUpInside(_ sender: UIButton) {
        // Request Sign Up
        self.dismissKeyboard()
        self.showIndicator()
        
        dataManager.postSignUp(userInfo, delegate: self)
    }
}


extension FinalViewController {
    func didSuccessSignUp(_ result: SignUpResult) {
        self.presentAlert(title: "회원가입에 성공하였습니다", message: result.jwt)
        
        //자동로그인을 위해 토큰 저장
        UserDefaults.standard.set(result.jwt, forKey: "LoginUserIdentifier")
        UserDefaults.standard.set(result.userIdx, forKey: "UserIdx")
        
        let mainTabBarController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(identifier: "MainTabBarController")
        self.changeRootViewController(mainTabBarController)
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
