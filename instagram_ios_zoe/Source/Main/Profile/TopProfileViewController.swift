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
        if let profileImageUrl = result.profileImg {
            let url = URL(string: profileImageUrl)
            self.profileImageView.kf.setImage(with: url)
        } else {
            self.profileImageView.image = UIImage(named: "고양이1")
        }
        // 이름
        self.userNameLabel.text = result.name
        // 게시물 개수
        self.postCountLabel.text = String(result.postCount)
        // 팔로워 수
        self.followerCountLabel.text = String(result.followingCount)
        // 팔로잉 수
        self.followingCountLabel.text = String(result.followerCount)
        if let introduction = result.introduction, let website = result.website {
            print("둘 다 존재")
            //self.introductionLabel.font = .NotoSans(.regular, size: 13)
            self.introductionLabel.text = introduction
            //self.websiteLabel.font = .NotoSans(.regular, size: 11)
            self.websiteLabel.text = website
        } else if (result.introduction == nil && result.website != nil) {
            print("소개글 없음")
            // 소개글이 없는 경우
            self.introductionLabel.isHidden = true
            
            // 프로필 편집 버튼 topAnchor 변경
            self.websiteLabelTopConstraint.isActive = false
            self.websiteLabelTopConstraint = websiteLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10)
            self.editProfileTopConstraint.isActive = true
            
            //self.websiteLabel.font = .NotoSans(.regular, size: 11)
            self.websiteLabel.text = result.website
            
        } else if (result.website == nil && result.introduction != nil) {
            print("웹 사이트 없음")
            // 웹사이트가 없는 경우
            websiteLabel.isHidden = true
            
            self.editProfileTopConstraint.isActive = false
            self.editProfileTopConstraint = editProfileButton.topAnchor.constraint(equalTo: introductionLabel.bottomAnchor, constant: 10)
            self.editProfileTopConstraint.isActive = true
            
            //self.introductionLabel.font = .NotoSans(.regular, size: 13)
            self.introductionLabel.text = result.introduction
        } else if(result.introduction == nil && result.website == nil) {
            print("둘 다 없음")
            // 둘 다 없는 경우
            self.introductionLabel.isHidden = true
            self.websiteLabel.isHidden = true
            self.editProfileTopConstraint.isActive = false
            self.editProfileTopConstraint = editProfileButton.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 5)
            self.editProfileTopConstraint.isActive = true
            
            profile.AfterUserIdx = result.userIdx
            profile.AfterUserId = result.userId
        }
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
