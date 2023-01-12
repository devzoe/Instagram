//
//  TopProfileViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/09.
//

import UIKit

class TopProfileViewController: UIViewController {
    lazy var dataManager: ProfileDataManager = ProfileDataManager()
    let profile = Profile.shared
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var postCountLabel: UILabel!
    
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var introductionLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var findUserButton: UIButton!
    @IBOutlet weak var introductionTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var editProfileTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var websiteLabelTopConstraint: NSLayoutConstraint!
   
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followerView: UIView!
    @IBOutlet weak var followingView: UIView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.findUserButton.setCornerRadius(10)
        self.editProfileButton.setCornerRadius(10)
        DispatchQueue.main.async {
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
            self.profileImageView.clipsToBounds = true
            //self.userNameLabel.font = .NotoSans(.medium, size: 13)
            //self.postLabel.font = .NotoSans(.regular, size: 15)
            //self.followerLabel.font = .NotoSans(.regular, size: 15)
            //self.followingLabel.font = .NotoSans(.regular, size: 15)
            //self.editProfileButton.titleLabel?.font = .NotoSans(.medium, size: 15)
        }
        self.dataManager.getProfileData(delegate: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didFollowerTapped(_:)))
        self.followerView.addGestureRecognizer(tapGestureRecognizer)
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(didFollowingTapped(_:)))
        self.followingView.addGestureRecognizer(tapGestureRecognizer2)
    }
    @objc func didFollowerTapped(_ sender: UITapGestureRecognizer) {
        print("did follower tapped", sender)
        let followerViewController = self.storyboard?.instantiateViewController(identifier: "FollowTabViewController") as! FollowTabViewController
        
        self.navigationController?.pushViewController(followerViewController, animated: true)
    }
    @objc func didFollowingTapped(_ sender: UITapGestureRecognizer) {
        print("did following tapped", sender)
        let followingViewController = self.storyboard?.instantiateViewController(identifier: "FollowTabViewController") as! FollowTabViewController
        
        self.navigationController?.pushViewController(followingViewController, animated: true)
        
    }
    @IBAction func editProfileButtonTouchUpInside(_ sender: UIButton) {
        let readProfileEditViewController = self.storyboard?.instantiateViewController(identifier: "ReadProfileEditViewController") as! ReadProfileEditViewController
        self.navigationController?.pushViewController(readProfileEditViewController, animated: true)
    }
}

extension TopProfileViewController {
    func didSetProfile(result: ProfileResult) {
        //self.presentAlert(title: "프로필 로딩에 성공하였습니다", message: result.userId)
        // 프로필 이미지
        print(result.profileImg)
        if let profileImageUrl = result.profileImg {
            let url = URL(string: profileImageUrl)
            self.profileImageView.kf.setImage(with: url)
        } else {
            self.profileImageView.image = UIImage(named: "default_profile")
        }
        // 이름
        self.userNameLabel.text = result.name
        // 게시물 개수
        self.postCountLabel.text = String(result.postCount)
        // 팔로워 수
        self.followerCountLabel.text = String(result.followingCount)
        // 팔로잉 수
        self.followingCountLabel.text = String(result.followerCount)
        
        if let name = result.name , let introduction = result.introduction, let website = result.website {
            print("셋다 있음")
            self.userNameLabel.text = name
            self.introductionLabel.text = introduction
            self.websiteLabel.text = website
        } else if (result.name != nil &&  result.introduction == nil && result.website == nil) {
            print("이름만 존재")
            self.userNameLabel.text = result.name
            self.introductionLabel.isHidden = true
            self.websiteLabel.isHidden = true
            
            self.editProfileTopConstraint.isActive = false
            self.editProfileTopConstraint = editProfileButton.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10)
            self.editProfileTopConstraint.isActive = true
        } else if (result.name == nil && result.introduction != nil && result.website == nil) {
            print("소개글만 존재")
            self.introductionLabel.text = result.introduction
            self.userNameLabel.isHidden = true
            self.websiteLabel.isHidden = true
            // 소개글 topAnchor 변경
            self.introductionTopConstraint.isActive = false
            self.introductionTopConstraint = introductionLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10)
            
            self.introductionTopConstraint.isActive = true
            self.editProfileTopConstraint.isActive = false
            self.editProfileTopConstraint = editProfileButton.topAnchor.constraint(equalTo: introductionLabel.bottomAnchor, constant: 10)
            self.editProfileTopConstraint.isActive = true
        } else if (result.name == nil && result.introduction == nil && result.website != nil) {
            print("웹사이트만 존재")
            self.websiteLabel.text = result.website
            self.userNameLabel.isHidden = true
            self.introductionLabel.isHidden = true
            // 소개글 topAnchor 변경
            self.websiteLabelTopConstraint.isActive = false
            self.websiteLabelTopConstraint = websiteLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10)
            self.websiteLabelTopConstraint.isActive = true
            // 프로필 topAnchor 변경
            self.editProfileTopConstraint.isActive = false
            self.editProfileTopConstraint = editProfileButton.topAnchor.constraint(equalTo: websiteLabel.bottomAnchor, constant: 10)
            self.editProfileTopConstraint.isActive = true
        } else if (result.name != nil && result.introduction != nil && result.website == nil) {
            print("웹 사이트 없음")
            websiteLabel.isHidden = true
            self.editProfileTopConstraint.isActive = false
            self.editProfileTopConstraint = editProfileButton.topAnchor.constraint(equalTo: introductionLabel.bottomAnchor, constant: 10)
            self.editProfileTopConstraint.isActive = true
            
            self.userNameLabel.text = result.name
            self.introductionLabel.text = result.introduction
            
        } else if (result.name != nil && result.introduction == nil && result.website != nil) {
            print("소개글 없음")
            // 소개글이 없는 경우
            self.introductionLabel.isHidden = true
            
            self.websiteLabelTopConstraint.isActive = false
            self.websiteLabelTopConstraint = websiteLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 5)
            self.editProfileTopConstraint.isActive = true
            
            self.userNameLabel.text = result.name
            self.websiteLabel.text = result.website
        } else if (result.name == nil && result.introduction != nil && result.website != nil) {
            print("이름만 없음")
            self.introductionLabel.text = result.introduction
            self.websiteLabel.text = result.website
            self.userNameLabel.isHidden = true
            
            // 소개글 topAnchor 변경
            self.introductionTopConstraint.isActive = false
            self.introductionTopConstraint = introductionLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10)
            self.introductionTopConstraint.isActive = true
        } else if(result.name == nil && result.introduction == nil && result.website == nil) {
            print("셋 다 없음")
            // 셋 다 없는 경우
            self.userNameLabel.isHidden = true
            self.introductionLabel.isHidden = true
            self.websiteLabel.isHidden = true
            
            self.editProfileTopConstraint.isActive = false
            self.editProfileTopConstraint = editProfileButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10)
            self.editProfileTopConstraint.isActive = true
        }
            profile.AfterUserIdx = result.userIdx
            profile.AfterUserId = result.userId
    }
    
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
