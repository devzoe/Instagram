//
//  HomeViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import UIKit

class HomeViewController: BaseViewController {
    @IBOutlet weak var instagramButton: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        instagramButton.titleLabel?.font = .billabong(size: 35)
    }
    override func viewDidLoad() {
    }
}
