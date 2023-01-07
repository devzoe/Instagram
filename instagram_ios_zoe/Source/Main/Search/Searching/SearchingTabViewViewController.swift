//
//  SearchingTabViewViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/07.
//
import UIKit
import Tabman
import Pageboy

class SearchingTabViewController: TabmanViewController {
    private var viewControllers: Array<UIViewController> = []
    var searchRequest : SearchRequest = SearchRequest(word: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        let firstVC = storyboard?.instantiateViewController(withIdentifier: "SearchAccountViewController") as! SearchAccountViewController
        viewControllers.append(firstVC)
        firstVC.searchRequest = searchRequest
        
        if let secondVC = storyboard?.instantiateViewController(withIdentifier: "SearchTagViewController") {
            viewControllers.append(secondVC)
        }
        if let thirdVC = storyboard?.instantiateViewController(withIdentifier: "SearchLocationViewController") {
            viewControllers.append(thirdVC)
        }
        self.dataSource = self
        self.setSearchingTabBarUI(self)
    }
        
}

extension SearchingTabViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
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
            title = "계정"
        } else if (index == 1) {
            title = "태그"
        } else if (index == 2) {
            title = "장소"
        }

        item.title = title
        return item
    }
}
