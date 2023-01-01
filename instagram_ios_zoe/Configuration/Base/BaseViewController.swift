//
//  BaseViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/01.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        self.navigationItem.backBarButtonItem?.tintColor = .black
        self.navigationController?.navigationBar.tintColor = .black
        self.tabBarController?.tabBar.tintColor = .black

    }
    
    


}
