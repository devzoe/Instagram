//
//  PhoneViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import UIKit

class PhoneViewController: BaseViewController {
    
    @IBOutlet weak var phoneNextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.phoneNextButton.setCornerRadius(10)
       
    }
    
    @IBAction func phoneNextButtonTouchUpInside(_ sender: UIButton) {
        let codeViewController = UIStoryboard(name: "SignUpStoryboard", bundle: nil).instantiateViewController(identifier: "CodeViewController")
        
        self.navigationController?.pushViewController(codeViewController, animated: true)
        
    }    
}
