//
//  NameViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import UIKit

class NameViewController: BaseViewController {
    var userInfo : SignUpRequest = SignUpRequest(userId: "", password: "", name: "", phone: "",email: "", birth: "", contract1: "", contract2: "", contract3: "")

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.isEnabled = false
            nextButton.backgroundColor = .buttonIsEnableFalse
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        self.nextButton.setCornerRadius(10)
    }
    
    @IBAction func nextButtonTouchUpInside(_ sender: UIButton) {
        userInfo.name = nameTextField.text!
        print(userInfo)
        let passwordViewController = UIStoryboard(name: "SignUpStoryboard", bundle: nil).instantiateViewController(identifier: "PasswordViewController") as! PasswordViewController
        passwordViewController.userInfo = userInfo
        self.navigationController?.pushViewController(passwordViewController, animated: true)
    }
}

extension NameViewController : UITextFieldDelegate {
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
