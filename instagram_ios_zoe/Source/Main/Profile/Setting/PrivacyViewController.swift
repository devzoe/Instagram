//
//  PrivacyViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/12.
//

import UIKit

class PrivacyViewController: UIViewController {
    lazy var profileDataManager = ProfilesUserInfoDataManager()
    var profileUserInfo = ProfilesUserInfoResult(userIdx: 0, email: "", phone: "", sex: "", birth: "")
    
    // Create right UIBarButtonItem.
    lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(buttonPressed(_:)))
        button.tag = 2
        return button
    }()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var sexTextField: UITextField!
    @IBOutlet weak var birthTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.rightButton
        setTextField(textfield: emailTextField)
        setTextField(textfield: phoneTextField)
        setTextField(textfield: sexTextField)
        setTextField(textfield: birthTextField)
        setUI()
    }
    func setTextField(textfield : UITextField) {
        textfield.borderStyle = .none
        let border = CALayer()
        border.frame = CGRect(x: 0, y: textfield.frame.size.height-1, width: textfield.frame.width, height: 1)
        border.backgroundColor = UIColor.white.cgColor
        textfield.layer.addSublayer((border))
        textfield.textAlignment = .left
        textfield.textColor = UIColor.white
    }
    func setUI() {
        self.emailTextField.textColor = .black
        self.emailTextField.text = profileUserInfo.email
        self.phoneTextField.textColor = .black
        self.phoneTextField.text = profileUserInfo.phone
        self.sexTextField.textColor = .black
        self.sexTextField.text = profileUserInfo.sex
        self.birthTextField.textColor = .black
        self.birthTextField.text = profileUserInfo.birth
    }
    @objc func buttonPressed(_ sender: Any) {
        var userInfo = UserInfoRequest(userIdx: UserDefaults.standard.integer(forKey: "UserIdx"))
        userInfo.email = emailTextField.text
        userInfo.phone = phoneTextField.text
        userInfo.sex = sexTextField.text
        userInfo.birth = birthTextField.text
        profileDataManager.setProfileInfo(userInfo, delegate: self)
    }
}

extension PrivacyViewController {
    func didUpdateUserInfo() {
        self.presentAlert(title: "개인 정보 수정 성공하였습니다", message: "")
        self.navigationController?.popViewController(animated: true)
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
