//
//  SignInViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/01.
//

import UIKit

class SignInViewController: BaseViewController {
    lazy var dataManager: SignInDataManager = SignInDataManager()

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.loginButton.setCornerRadius(10)
        self.idTextField.setPlaceHolder("전화번호, 사용자 이름 또는 이메일", .darkGray)
        self.passwordTextField.setPlaceHolder("비밀번호", .darkGray)
    }
    
    @IBAction func loginButtonTouchUpInside(_ sender: UIButton) {
        // ID validation
        guard let id = idTextField.text?.trim, id.isExists else {
            self.presentAlert(title: "아이디를 입력해주세요")
            return
        }
        
        // Password validation
        guard let password = passwordTextField.text, password.isExists else {
            self.presentAlert(title: "비밀번호를 입력해주세요")
            return
        }
        
        // Request Sign In
        self.dismissKeyboard()
        self.showIndicator()
        
        if (isValidEmail(testStr: id)) {
            let input = SignInRequest(email: id, phone: "", password: password)
            dataManager.postSignIn(input, delegate: self)
        } else {
            let input = SignInRequest(email: "", phone: id, password: password)
            dataManager.postSignIn(input, delegate: self)
        }
    }
    
    @IBAction func signUpButtonTouchUpInside(_ sender: UIButton) {
        let signUpViewController = UIStoryboard(name: "SignUpStoryboard", bundle: nil).instantiateViewController(identifier: "SignUpNavigationController")
        signUpViewController.modalPresentationStyle = .fullScreen
        self.present(signUpViewController, animated: true, completion: nil)
        
    }
}

extension SignInViewController {
    func didSuccessSignIn(_ result: SignInResult) {
        self.presentAlert(title: "로그인에 성공하였습니다", message: result.jwt)
        
        //자동로그인을 위해 토큰 저장
        //UserDefaults.standard.set(result.token, forKey: "LoginUserIdentifier")
        
        let mainTabBarController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(identifier: "MainTabBarController")
        self.changeRootViewController(mainTabBarController)
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
