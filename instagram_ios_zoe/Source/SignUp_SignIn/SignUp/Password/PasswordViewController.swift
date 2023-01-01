//
//  PasswordViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import UIKit

class PasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func nextButtonTouchUpInside(_ sender: UIButton) {
        let bdayViewController = UIStoryboard(name: "SignUpStoryboard", bundle: nil).instantiateViewController(identifier: "BirthdayViewController")
        
        self.navigationController?.pushViewController(bdayViewController, animated: true)
    }
    
}
