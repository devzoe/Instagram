//
//  FollowTabViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/10.
//

import UIKit
import Tabman
import Pageboy

class FollowTabViewController: TabmanViewController {
    lazy var dataManager : FollowDataManager = FollowDataManager()
    private var viewControllers: Array<UIViewController> = []
    var followerResult : [FollowerResult] = []
    var followingResult : [FollowingResult] = []
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let firstVC = storyboard?.instantiateViewController(withIdentifier: "FollowerViewController") {
            viewControllers.append(firstVC)
            
        }
        if let secondVC = storyboard?.instantiateViewController(withIdentifier: "FollowingViewController") {
            viewControllers.append(secondVC)
        }
        
        
        self.setFollowTabBarUI(self)
        self.dataManager.gotFollower(delegate: self)
                
    }
        
}
extension FollowTabViewController {
    func didGetFollower(result: [FollowerResult]) {
        self.followerResult = result
        if let followerVC = storyboard?.instantiateViewController(withIdentifier: "FollowerViewController") as? FollowerViewController {
            followerVC.followerResult = followerResult
        }
        self.dataManager.gotFollowing(delegate: self)


    }
    func didGetFollowing(result: [FollowingResult]) {
        self.followingResult = result
        if let followingVC = storyboard?.instantiateViewController(withIdentifier: "FollowingViewController") as? FollowingViewController {
            followingVC.followingResult = followingResult
        }
        self.dataSource = self
    }
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}

extension FollowTabViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
        // return .at(index: 0) -> index를 통해 처음에 보이는 탭을 설정할 수 있다.
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let item = TMBarItem(title: "")
         var title: String = ""
        if (index == 0) {
            title = "\(followerResult.count) 팔로워"
        } else if (index == 1) {
            title = "\(followingResult.count) 팔로잉"
        }

        item.title = title
        return item
    }
}
