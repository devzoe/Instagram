//
//  ProfileViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/03.
//

import UIKit

class ProfileViewController: BaseViewController {

    @IBOutlet weak var profileEditButton: UIButton!
    @IBOutlet weak var findPeopleButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.findPeopleButton.setCornerRadius(10)
        self.profileEditButton.setCornerRadius(10)
    }
}
