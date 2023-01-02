//
//  EmailViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import UIKit

class EmailViewController: BaseViewController {

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
        let codeViewController = UIStoryboard(name: "SignUpStoryboard", bundle: nil).instantiateViewController(identifier: "EmailAuthCodeViewController")
        self.navigationController?.pushViewController(codeViewController, animated: true)
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
