//
//  AuthCodeViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import UIKit

class PhoneAuthCodeViewController: BaseViewController {
    var userInfo : SignUpRequest = SignUpRequest(userId: "", password: "", name: "", phone: "", email: "", birth: "", contract1: "", contract2: "", contract3: "")
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var codeNumberNextButton: UIButton! {
        didSet {
            codeNumberNextButton.isEnabled = false
            codeNumberNextButton.backgroundColor = .buttonIsEnableFalse
        }
    }
    
    @IBOutlet weak var codeNumTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.codeNumTextField.delegate = self
        self.codeNumberNextButton.setCornerRadius(10)
        self.codeNumTextField.keyboardType = .numberPad
    }
    @IBAction func codeNumberNextButtonTouchUpInside(_ sender: UIButton) {
        let nameViewController = UIStoryboard(name: "SignUpStoryboard", bundle: nil).instantiateViewController(identifier: "NameViewController") as! NameViewController
        nameViewController.userInfo = userInfo
        self.navigationController?.pushViewController(nameViewController, animated: true)
    }

}

extension PhoneAuthCodeViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
            replacementString string: String) -> Bool {
        if (range.location == 0 && range.length != 0) {
            self.codeNumberNextButton.isEnabled = false
            self.codeNumberNextButton.backgroundColor = .buttonIsEnableFalse
        } else {
            self.codeNumberNextButton.isEnabled = true
            self.codeNumberNextButton.backgroundColor = .buttonIsEnableTrue
        }
        return true
    }
}
