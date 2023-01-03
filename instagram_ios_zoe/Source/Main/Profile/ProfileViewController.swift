//
//  ProfileViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/03.
//

import UIKit
import Kingfisher

class ProfileViewController: BaseViewController {
    lazy var dataManager: ProfileDataManager = ProfileDataManager()

    @IBOutlet weak var userIdBarButton: UIBarButtonItem!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    
    @IBOutlet weak var profileEditButton: UIButton!
    @IBOutlet weak var findPeopleButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.findPeopleButton.setCornerRadius(10)
        self.profileEditButton.setCornerRadius(10)
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
        self.profileImageView.clipsToBounds = true
        
        self.dataManager.getProfileData(delegate: self)
    }
}

extension ProfileViewController {
    func didSetProfile(result: ProfileResult) {
        self.presentAlert(title: "프로필 로딩에 성공하였습니다", message: result.userId)
        // 아이디
        userIdBarButton.title = result.userId
        // 프로필 이미지
        if let profileImageUrl = result.profileImg {
            let url = URL(string: profileImageUrl)
            profileImageView.kf.setImage(with: url)
        } else {
            profileImageView.image = UIImage(named: "고양이1")
        }
        // 이름
        userNameLabel.text = result.name
        // 게시물 개수
        postCountLabel.text = String(result.postCount)
        // 팔로워 수
        followerCountLabel.text = String(result.followerCount)
        // 팔로잉 수
        followingCountLabel.text = String(result.followingCount)
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
