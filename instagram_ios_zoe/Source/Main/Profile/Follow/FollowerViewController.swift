//
//  FollowerViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/10.
//

import UIKit

class FollowerViewController: BaseViewController {
    lazy var dataManager : FollowDataManager = FollowDataManager()
    var followerResult : [FollowerResult] = []
    let cellId = "FollowerTableViewCell"
    let profile = Profile.shared
    @IBOutlet weak var followerTableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("follower viewwillappear")
        
        self.setTableView()
        let userIdx = profile.AfterUserIdx
        self.dataManager.gotFollowerInTable(userIdx: userIdx,delegate: self)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("follower viewdidappear")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("follower viewdidload")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("follower view will disappear")
        followerResult.removeAll()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("follower view did disappear")
    }
    func setTableView() {
        self.followerTableView.delegate = self
        self.followerTableView.dataSource = self
        //self.followerTableView.register(FollowerTableViewCell.self, forCellReuseIdentifier: cellId)
    }
}

extension FollowerViewController {
    func didGetFollower(result: [FollowerResult]) {
        for i in 0..<result.count {
            if (result[i].followYn == "ACTIVE") {
                self.followerResult.append(result[i])
            }
        }
        print(followerResult)
        self.followerTableView.reloadData()
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}

extension FollowerViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followerResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = followerTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FollowerTableViewCell
        
        let cellData = followerResult[indexPath.row]
        cell.get(data: cellData)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileTableViewController") as! UserProfileTableViewController
        let profileId = followerResult[indexPath.row].id
        let profileIdx = followerResult[indexPath.row].userIdx
        profile.BeforeUserId = profile.AfterUserId
        profile.BeforeUserIdx = profile.AfterUserIdx
        profile.AfterUserId = profileId
        profile.AfterUserIdx = profileIdx
        print("profileId : ", profileId)
        print("profileIdx: ", profileIdx)
        self.navigationController?.pushViewController(profileVC, animated: true)
        
    }
}
