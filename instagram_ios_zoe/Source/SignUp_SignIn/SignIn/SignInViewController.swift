//
//  SignInViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/01.
//

import UIKit

class SignInViewController: BaseViewController {

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
        let mainTabBarController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(identifier: "MainTabBarController")
        self.changeRootViewController(mainTabBarController)
    }
    
}
