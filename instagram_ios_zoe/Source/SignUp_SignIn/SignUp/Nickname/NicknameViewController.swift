//
//  NicknameViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import UIKit

class NicknameViewController: UIViewController {

    @IBOutlet weak var nicknameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonTouchUpInside(_ sender: UIButton) {
        let finalViewController = UIStoryboard(name: "SignUpStoryboard", bundle: nil).instantiateViewController(identifier: "FinalViewController")
        
        self.navigationController?.pushViewController(finalViewController, animated: true)
    }
    
    @IBAction func signUpButtonTouchUpInside(_ sender: UIButton) {
        let mainTabBarController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(identifier: "MainTabBarController")
        self.changeRootViewController(mainTabBarController)
    }
    
}
