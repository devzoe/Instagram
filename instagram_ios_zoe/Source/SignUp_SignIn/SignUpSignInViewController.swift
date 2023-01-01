//
//  SingUpSignInViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/01.
//

import UIKit

class SignUpSignInViewController: BaseViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.signUpButton.setCornerRadius(10)
    }
    
    @IBAction func signUpButtonTouchUpInside(_ sender: UIButton) {
        let signUpViewController = UIStoryboard(name: "SignUpStoryboard", bundle: nil).instantiateViewController(identifier: "SignUpNavigationController")
        signUpViewController.modalPresentationStyle = .fullScreen
        self.present(signUpViewController, animated: true, completion: nil)
    }
    @IBAction func signInButtonTouchUpInside(_ sender: UIButton) {
        let signInViewController = UIStoryboard(name: "SignInStoryboard", bundle: nil).instantiateViewController(identifier: "SignInViewController")
        signInViewController.modalPresentationStyle = .fullScreen
        self.present(signInViewController, animated: true, completion: nil)
    }
    

}
