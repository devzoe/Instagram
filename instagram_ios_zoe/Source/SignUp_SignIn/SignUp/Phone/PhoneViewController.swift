//
//  PhoneViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import UIKit

class PhoneViewController: BaseViewController {
    var userInfo : SignUpRequest = SignUpRequest(userId: "", password: "", name: "", phone: "", email: "", birth: "", contract1: "", contract2: "", contract3: "")
    
    @IBOutlet weak var phoneNextButton: UIButton! {
        didSet {
            phoneNextButton.isEnabled = false
            phoneNextButton.backgroundColor = .buttonIsEnableFalse
        }
    }

    @IBOutlet weak var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.phoneTextField.delegate = self
        self.phoneNextButton.setCornerRadius(10)
        self.phoneTextField.keyboardType = .numberPad
       
    }
    
    @IBAction func phoneNextButtonTouchUpInside(_ sender: UIButton) {
        
        userInfo.phone = phoneTextField.text!
        print(userInfo)
        let codeViewController = UIStoryboard(name: "SignUpStoryboard", bundle: nil).instantiateViewController(identifier: "PhoneAuthCodeViewController") as! PhoneAuthCodeViewController
        codeViewController.userInfo = userInfo
        self.navigationController?.pushViewController(codeViewController, animated: true)
    }    
}

extension PhoneViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
            replacementString string: String) -> Bool {
        if (range.location == 0 && range.length != 0) {
            self.phoneNextButton.isEnabled = false
            self.phoneNextButton.backgroundColor = .buttonIsEnableFalse
        } else {
            self.phoneNextButton.isEnabled = true
            self.phoneNextButton.backgroundColor = .buttonIsEnableTrue
        }
        return true
    }
}
