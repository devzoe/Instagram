//
//  ServiceAgreementViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import UIKit

class ServiceAgreementViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  

    @IBAction func nextButtonTouchUpInside(_ sender: UIButton) {
        let nicknameViewController = UIStoryboard(name: "SignUpStoryboard", bundle: nil).instantiateViewController(identifier: "NicknameViewController")
        
        self.navigationController?.pushViewController(nicknameViewController, animated: true)
    }
    
}
