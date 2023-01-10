//
//  UserTabViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/11.
//

import UIKit
import Tabman
import Pageboy

class UserTabViewController: TabmanViewController {
    private var viewControllers: Array<UIViewController> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let firstVC = storyboard?.instantiateViewController(withIdentifier: "UserPostViewController") {
            viewControllers.append(firstVC)
        }
        if let secondVC = storyboard?.instantiateViewController(withIdentifier: "UserTagPostViewController") {
            viewControllers.append(secondVC)
        }
        self.dataSource = self
        self.setUserProfileTabBarUI(self)
    }
        
}

extension UserTabViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
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
        if (index == 0) {
            //item.title = "게시물"
            item.image = UIImage(systemName: "squareshape.split.3x3")
        } else if (index == 1) {
            //item.title = "태그된 게시물"
            item.image = UIImage(systemName: "person.crop.rectangle")
        }
        return item
    }
}
