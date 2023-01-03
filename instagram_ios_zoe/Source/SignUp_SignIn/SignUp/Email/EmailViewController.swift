//
//  EmailViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import UIKit

class EmailViewController: BaseViewController {
    var userInfo : SignUpRequest = SignUpRequest(userId: "", password: "", name: "", phone: "", email: "", birth: "", contract1: "", contract2: "", contract3: "")

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailNextButton: UIButton! {
        didSet {
            emailNextButton.isEnabled = false
            emailNextButton.backgroundColor = .buttonIsEnableFalse
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        self.emailNextButton.setCornerRadius(10)
    }
    @IBAction func emailNextButtonTouchUpInside(_ sender: UIButton) {
        
        if (isValidEmail(testStr: emailTextField.text!)){
            userInfo.email = emailTextField.text!
            print(userInfo)
            let codeViewController = UIStoryboard(name: "SignUpStoryboard", bundle: nil).instantiateViewController(identifier: "EmailAuthCodeViewController") as! EmailAuthCodeViewController
            //codeViewController.userInfo = userInfo
            self.navigationController?.pushViewController(codeViewController, animated: true)
        } else {
            print("올바른 이메일 주소를 입력하세요.")
        }
    }
    
}

extension EmailViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
            replacementString string: String) -> Bool {
        if (range.location == 0 && range.length != 0) {
            self.emailNextButton.isEnabled = false
            self.emailNextButton.backgroundColor = .buttonIsEnableFalse
        } else {
            self.emailNextButton.isEnabled = true
            self.emailNextButton.backgroundColor = .buttonIsEnableTrue
        }
        return true
    }
}
