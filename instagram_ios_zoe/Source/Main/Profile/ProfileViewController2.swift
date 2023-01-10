//
//  ProfileViewController2.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/08.
//

import UIKit

class ProfileViewController2: BaseViewController {
    lazy var dataManager: ProfileDataManager = ProfileDataManager()
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var postCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var introductionLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    
    @IBOutlet weak var userIdBarButton: UIBarButtonItem!
    
    @IBOutlet weak var profileEditButton: UIButton!
    @IBOutlet weak var recommendUserButton: UIButton!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerView2: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("profile view will appear")
        //DispatchQueue.main.async {
            
            //self.recommendUserButton.setCornerRadius(10)
            //self.profileEditButton.setCornerRadius(10)
            //self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
            //self.profileImageView.clipsToBounds = true
        DispatchQueue.global().sync {
            //self.setUpTableView()
        }
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("profile view did appear")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
        self.setUpTableView()
        print("table view 완료")
        self.tableView.tableHeaderView = self.headerView
        self.tableView.tableFooterView = self.headerView2
        //self.dataManager.getProfileData(delegate: self)

        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("profile view will disappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("profile view did disappear")
    }
    func setUpTableView() {
        print("table view")

        self.tableView.delegate = self
        print("table view1")
        
        self.tableView.dataSource = self
        print("table view2")
        //self.tableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
        print("table view3")
    }
    
    @IBAction func profileEditButtonTouchUpInside(_ sender: UIButton) {
        let readProfileEditViewController = self.storyboard?.instantiateViewController(identifier: "ReadProfileEditViewController") as! ReadProfileEditViewController
        self.navigationController?.pushViewController(readProfileEditViewController, animated: true)
    }
    @IBAction func recommendUserButtonTouchUpInside(_ sender: UIButton) {
    }
    @IBAction func createPostTouchUpInside(_ sender: UIButton) {
        let createModalViewController = self.storyboard?.instantiateViewController(identifier: "CreateModalViewController") as! CreateModalViewController
        self.present(createModalViewController, animated: true, completion: nil)
    }
    @IBAction func settingButtonTouchUpInside(_ sender: UIButton) {
    }
    
}
extension ProfileViewController2 : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count")
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell
        //print("cell : ", cell)
        //return cell ?? UITableViewCell()
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(1)
    }
}

extension ProfileViewController2 {
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
