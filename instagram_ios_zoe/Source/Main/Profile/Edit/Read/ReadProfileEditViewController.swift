//
//  ReadProfileEditViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/07.
//

import UIKit
import Kingfisher

class ReadProfileEditViewController: BaseViewController {
    lazy var dataManager : ReadProfileEditDataManager = ReadProfileEditDataManager()
    lazy var editDataManager : EditProfileDataManager = EditProfileDataManager()
    var editProfileRequest : EditProfileRequest = EditProfileRequest(userIdx: 0, userId: "", name: "", profileImage: nil, website: nil, introduction: nil)
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var introductionTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    
    // Create right UIBarButtonItem.
    lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(buttonPressed(_:)))
        button.tag = 2
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
            self.profileImageView.clipsToBounds = true
        }
        setTextField(textfield: userIdTextField)
        setTextField(textfield: userNameTextField)
        setTextField(textfield: introductionTextField)
        setTextField(textfield: websiteTextField)
        self.dataManager.getProfileData(delegate: self)
        // Set it to the right of the navigation bar.
        self.navigationItem.rightBarButtonItem = self.rightButton
    }
    
    @objc func buttonPressed(_ sender: Any) {
        setData()
        editDataManager.editProfileData(editProfileRequest, delegate: self)
    }
    func setData() {
        editProfileRequest.profileImage = "https://firebasestorage.googleapis.com/v0/b/imagetest-e4d50.appspot.com/o/6E952A1A-B1C9-4F23-A588-94C48A788B561672994546.275323?alt=media&token=1e8ebd92-e1f0-4c1a-9c8b-5bc383b762f1"
        editProfileRequest.name = userNameTextField.text!
        editProfileRequest.userId = userIdTextField.text!
        editProfileRequest.introduction = introductionTextField.text!
        if (websiteTextField.text?.isEmpty == true) {
            editProfileRequest.website = nil
        } else {
            editProfileRequest.website = websiteTextField.text
        }
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
}

extension ReadProfileEditViewController {
    func didSetProfile(result: ReadProfileEditResult) {
        //self.presentAlert(title: "프로필 로딩에 성공하였습니다", message: result.userId)
        DispatchQueue.main.async {
            if let url = result.profileImg {
                self.profileImageView.kf.setImage(with: URL(string: url))
            } else {
                self.profileImageView.image = UIImage(named: "고양이1")
            }
            self.userNameTextField.textColor = .black
            self.userIdTextField.textColor = .black
            self.userNameTextField.text = result.name
            self.userIdTextField.text = result.userId
            if let introduction = result.introduction {
                self.introductionTextField.textColor = .black
                self.introductionTextField.text = introduction
            } else {
                self.introductionTextField.textColor = .lightGray
                self.introductionTextField.placeholder = "소개"
            }
            if let website = result.website {
                self.websiteTextField.textColor = .black
                self.websiteTextField.text = website
            } else {
                self.websiteTextField.textColor = .lightGray
                self.websiteTextField.placeholder = "링크 추가"
            }
        }
    }
    func didUpdateProfile(result : EditProfileResponse) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}

