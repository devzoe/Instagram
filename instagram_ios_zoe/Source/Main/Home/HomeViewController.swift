//
//  HomeViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import UIKit

class HomeViewController: BaseViewController {
    @IBOutlet weak var instagramButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instagramButton.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.billabong(size: 35)], for: .normal)
    }
}
