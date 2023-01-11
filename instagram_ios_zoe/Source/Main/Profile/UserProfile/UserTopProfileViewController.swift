//
//  UserTopProfileViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/11.
//

import UIKit

class UserTopProfileViewController: UIViewController {
    lazy var dataManager: UserProfileDataManager = UserProfileDataManager()
    lazy var followDataManager = FollowDataManager()
    var followYn = ""
    let profile = Profile.shared
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var postCountLabel: UILabel!
    
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var introductionLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    
    @IBOutlet weak var followYnButton: UIButton!
    
    
    @IBOutlet weak var findUserButton: UIButton!
    
    @IBOutlet weak var messageButton: UIButton!
    
    @IBOutlet weak var websiteLabelTopConstraint: NSLayoutConstraint!
   
    @IBOutlet weak var followYnButtonTopConstraint: NSLayoutConstraint!

    @IBOutlet weak var followerView: UIView!
    @IBOutlet weak var followingView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.findUserButton.setCornerRadius(10)
        self.followYnButton.setCornerRadius(10)
        self.messageButton.setCornerRadius(10)
        DispatchQueue.main.async {
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
            self.profileImageView.clipsToBounds = true
        }
        let profileIdx = profile.AfterUserIdx
        self.dataManager.getProfileData(profileIdx: profileIdx, delegate: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = profile.AfterUserId

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
    
    @IBAction func followYnButtonTouchUpInside(_ sender: UIButton) {
        if (followYn == "ACTIVE") { // 이미 팔로우 함. 누르면 언팔
            let followIdx = String(profile.AfterUserIdx)
            let status = "INACTIVE"
            let followRequest = FollowRequest(followIdx: followIdx, status: status)
            self.followDataManager.setFollow(followRequest, delegate: self)
            
        } else { // 팔로우 해야 함. 누르면 팔로잉
            let followIdx = String(profile.AfterUserIdx)
            let status = "ACTIVE"
            let followRequest = FollowRequest(followIdx: followIdx, status: status)
            self.followDataManager.setFollow(followRequest, delegate: self)
        }
        
    }
    
}

extension UserTopProfileViewController {
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
            self.followYnButtonTopConstraint.isActive = true
            
            //self.websiteLabel.font = .NotoSans(.regular, size: 11)
            self.websiteLabel.text = result.website
            
        } else if (result.website == nil && result.introduction != nil) {
            print("웹 사이트 없음")
            // 웹사이트가 없는 경우
            websiteLabel.isHidden = true
            
            self.followYnButtonTopConstraint.isActive = false
            self.followYnButtonTopConstraint = followYnButton.topAnchor.constraint(equalTo: introductionLabel.bottomAnchor, constant: 10)
            self.followYnButtonTopConstraint.isActive = true
            
            //self.introductionLabel.font = .NotoSans(.regular, size: 13)
            self.introductionLabel.text = result.introduction
        } else if(result.introduction == nil && result.website == nil) {
            print("둘 다 없음")
            // 둘 다 없는 경우
            self.introductionLabel.isHidden = true
            self.websiteLabel.isHidden = true
            self.followYnButtonTopConstraint.isActive = false
            self.followYnButtonTopConstraint = followYnButton.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 5)
            self.followYnButtonTopConstraint.isActive = true
        }
        
        if (result.followStatus == "ACTIVE") {
            self.followYn = "ACTIVE"
            self.followYnButton.setTitle("팔로잉", for: .normal)
            self.followYnButton.backgroundColor = .lightGray
            self.followYnButton.titleLabel?.tintColor = .black
        } else {
            self.followYn = "INACTIVE"
            self.followYnButton.setTitle("팔로우", for: .normal)
            self.followYnButton.backgroundColor = .blue
            self.followYnButton.titleLabel?.tintColor = .white
        }
        
        
    }
    func didSuccessFollow() {
        if (followYn == "ACTIVE") { // 이미 팔로우 함
            self.followYn = "INACTIVE"
            self.followYnButton.setTitle("팔로우", for: .normal)
            self.followYnButton.backgroundColor = .blue
            self.followYnButton.titleLabel?.tintColor = .white
            
        } else { // 팔로우 해야 함.
            self.followYn = "ACTIVE"
            self.followYnButton.setTitle("팔로잉", for: .normal)
            self.followYnButton.backgroundColor = .lightGray
            self.followYnButton.titleLabel?.tintColor = .black
        }
        
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
