//
//  TabViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/01.
//

import UIKit
import Tabman
import Pageboy

class TabViewController: TabmanViewController {
    private var viewControllers: Array<UIViewController> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let firstVC = storyboard?.instantiateViewController(withIdentifier: "PhoneViewController") {
            viewControllers.append(firstVC)
        }
        if let secondVC = storyboard?.instantiateViewController(withIdentifier: "EmailViewController") {
            viewControllers.append(secondVC)
        }

        self.dataSource = self
        self.setTabBarUI(self)
    
    }
        
}

extension TabViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
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
            title = "전화번호"
        } else if (index == 1) {
            title = "이메일"
        }
        item.title = title
        return item
    }
}
