//
//  ReadProfileEditViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/07.
//

import UIKit
import Kingfisher
import FirebaseStorage
import Firebase

class ReadProfileEditViewController: BaseViewController {
    lazy var dataManager : ReadProfileEditDataManager = ReadProfileEditDataManager()
    lazy var editDataManager : EditProfileDataManager = EditProfileDataManager()
    var editProfileRequest : EditProfileRequest = EditProfileRequest(userIdx: 0, userId: "", name: "", profileImage: "", website: nil, introduction: nil)
    let imagePicker = UIImagePickerController()
    
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
        self.imagePicker.sourceType = .photoLibrary // 앨범에서 가져옴
        self.imagePicker.allowsEditing = true // 수정 가능 여부
        self.imagePicker.delegate = self // picker delegate
    }
    
    @objc func buttonPressed(_ sender: Any) {
        self.setData()
        print("url : ", self.editProfileRequest.profileImage)
        self.editDataManager.editProfileData(editProfileRequest, delegate: self)
    }
    func setData() {
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
    @IBAction func profileImageButtonTouchUpInside(_ sender: UIButton) {
        self.present(self.imagePicker, animated: true)
    }
}

extension ReadProfileEditViewController {
    func didSetProfile(result: ReadProfileEditResult) {
        //self.presentAlert(title: "프로필 로딩에 성공하였습니다", message: result.userId)
        DispatchQueue.main.async {
            // 이미지
            if let url = result.profileImg {
                self.profileImageView.kf.setImage(with: URL(string: url))
            } else {
                self.profileImageView.image = UIImage(named: "default_profile")
            }
            self.userNameTextField.textColor = .black
            self.userIdTextField.textColor = .black
            self.introductionTextField.textColor = .black
            self.websiteTextField.textColor = .black
            self.userNameTextField.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.labelGray])
            self.userIdTextField.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.labelGray])
            self.introductionTextField.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.labelGray])
            self.websiteTextField.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.labelGray])
            
            if let name = result.name {
                self.userNameTextField.text = name
            } else {
                self.userNameTextField.placeholder = "이름"
            }
            self.userIdTextField.text = result.userId
            if let introduction = result.introduction {
                self.introductionTextField.text = introduction
            } else {
                self.introductionTextField.placeholder = "소개"
            }
            if let website = result.website {
                self.websiteTextField.text = website
            } else {
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

extension ReadProfileEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var newImage: UIImage? = nil // update 할 이미지
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage // 수정된 이미지가 있을 경우
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage // 원본 이미지가 있을 경우
        }
        self.profileImageView.image = newImage // 받아온 이미지를 update
        let data = newImage?.jpegData(compressionQuality: 1)
        FirebaseStorageManager.uploadImage(imageData: data!, pathRoot: "image") { url in
            if let url = url {
                let urlString = url.absoluteString
                self.editProfileRequest.profileImage = urlString
                print("url add", urlString)
                print("url add", self.editProfileRequest.profileImage)
            }
        }
        picker.dismiss(animated: true, completion: nil) // picker를 닫아줌
    }
}
