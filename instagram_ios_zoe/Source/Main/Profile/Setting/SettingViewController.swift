//
//  SettingViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/11.
//

import UIKit

class SettingViewController: BaseViewController {
    lazy var profileDataManager = ProfilesUserInfoDataManager()
    lazy var logOutDataManager = LogOutDataManager()
    var email = ""
    var phone = ""
    var profileUserInfo = ProfilesUserInfoResult(userIdx: 0, email: "", phone: "", sex: "", birth: "")
    var logOutRequest = LogOutRequest(email: "", phone: "")
    @IBOutlet weak var accountView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        profileDataManager.getProfileInfo(delegate: self)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didPrivacyTapped(_:)))
        self.accountView.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func didPrivacyTapped(_ sender: UITapGestureRecognizer) {
        
        let privacyViewController = self.storyboard?.instantiateViewController(identifier: "PrivacyViewController") as! PrivacyViewController
        privacyViewController.profileUserInfo = profileUserInfo
        self.navigationController?.pushViewController(privacyViewController, animated: true)
    }
    
    @IBAction func logOutButtonTouchUpInside(_ sender: UIButton) {
        let action = UIAlertAction(title: "로그아웃", style: .default) { action in
            self.logOutRequest.email = self.email
            self.logOutRequest.phone = self.phone
            print(self.logOutRequest)
            self.logOutDataManager.logOut(self.logOutRequest, delegate: self)
        }
        self.presentAlert(title: "로그아웃 하시겠어요?", isCancelActionIncluded: true, with: action)
    }
    
}

extension SettingViewController {
    func didSuccessLogOut(_ result: LogOutResponse) {
        self.presentAlert(title: "로그아웃 성공하였습니다", message: "")
        
        let signUpSignInController = UIStoryboard(name: "SignUpSignInStoryboard", bundle: nil).instantiateViewController(identifier: "SignUpSignInViewController")
        self.changeRootViewController(signUpSignInController)
    }
    func didSuccessProfileUserInfo(result: ProfilesUserInfoResult) {
        if let email = result.email {
            self.email = email
            print(email)
        } else {
            email = ""
        }
        if let phone = result.phone {
            self.phone = phone
            print(phone)
        } else {
            phone = ""
        }
        self.profileUserInfo = result
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
