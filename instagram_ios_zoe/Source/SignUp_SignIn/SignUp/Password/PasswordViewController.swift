//
//  PasswordViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import UIKit

class PasswordViewController: BaseViewController {
    var userInfo : SignUpRequest = SignUpRequest(userId: "", password: "", name: "", phone: "", email: "", birth: "", contract1: "", contract2: "", contract3: "")

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.isEnabled = false
            nextButton.backgroundColor = .buttonIsEnableFalse
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.delegate = self
        self.nextButton.setCornerRadius(10)
    }
    
    @IBAction func nextButtonTouchUpInside(_ sender: UIButton) {
        userInfo.password = passwordTextField.text!
        print(userInfo)
        let bdayViewController = UIStoryboard(name: "SignUpStoryboard", bundle: nil).instantiateViewController(identifier: "BirthdayViewController") as! BirthdayViewController
        bdayViewController.userInfo = userInfo
        self.navigationController?.pushViewController(bdayViewController, animated: true)
    }
}

extension PasswordViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
            replacementString string: String) -> Bool {
        if (range.location == 0 && range.length != 0) {
            self.nextButton.isEnabled = false
            self.nextButton.backgroundColor = .buttonIsEnableFalse
        } else {
            self.nextButton.isEnabled = true
            self.nextButton.backgroundColor = .buttonIsEnableTrue
        }
        return true
    }
}

