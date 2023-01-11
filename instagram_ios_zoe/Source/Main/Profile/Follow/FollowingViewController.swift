//
//  FollowingViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/10.
//

import UIKit

class FollowingViewController: BaseViewController {
    lazy var dataManager : FollowDataManager = FollowDataManager()
    var followingResult : [FollowingResult] = []
    let cellId = "FollowingTableViewCell"
    let profile = Profile.shared
    @IBOutlet weak var followingTableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("following viewwillappear")
        self.setTableView()
        let userIdx = profile.profileIdx
        self.dataManager.gotFollowingInTable(userIdx: userIdx, delegate: self)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("following viewdidappear")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("following viewdidload")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("following view will disappear")
        followingResult.removeAll()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("following view did disappear")
    }
    func setTableView() {
        self.followingTableView.delegate = self
        self.followingTableView.dataSource = self
       // self.followingTableView.register(FollowingTableViewCell.self, forCellReuseIdentifier: cellId)
    }
}
extension FollowingViewController {
    func didGetFollowing(result: [FollowingResult]) {
        for i in 0..<result.count {
            if (result[i].followYn == "ACTIVE") {
                self.followingResult.append(result[i])
            }
        }
        
        self.followingTableView.reloadData()
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
extension FollowingViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followingResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = followingTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FollowingTableViewCell
        
        let cellData = followingResult[indexPath.row]
        cell.get(data: cellData)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileTableViewController") as! UserProfileTableViewController
        let profileId = followingResult[indexPath.row].id
        let profileIdx = followingResult[indexPath.row].userIdx
        profileVC.profileId = profileId
        profile.profileIdx = profileIdx
        print("profileId : ", profileId)
        print("profileIdx: ", profileIdx)
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
}

