//
//  PhoneViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import UIKit

class PhoneViewController: UIViewController {
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func phoneNextButtonTouchUpInside(_ sender: UIButton) {
        let codeViewController = UIStoryboard(name: "SignUpStoryboard", bundle: nil).instantiateViewController(identifier: "CodeViewController")
        
        self.navigationController?.pushViewController(codeViewController, animated: true)
        
    }
    @IBAction func codeNumberNextButtonTouchUpInside(_ sender: UIButton) {
        let nameViewController = UIStoryboard(name: "SignUpStoryboard", bundle: nil).instantiateViewController(identifier: "NameViewController")
        
        self.navigationController?.pushViewController(nameViewController, animated: true)
    }
    
}
