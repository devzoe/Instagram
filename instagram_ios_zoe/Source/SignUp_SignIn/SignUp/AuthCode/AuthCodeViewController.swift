//
//  AuthCodeViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import UIKit

class AuthCodeViewController: BaseViewController {
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var codeNumberNextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.codeNumberNextButton.setCornerRadius(10)
        // Do any additional setup after loading the view.
    }
    @IBAction func codeNumberNextButtonTouchUpInside(_ sender: UIButton) {
        let nameViewController = UIStoryboard(name: "SignUpStoryboard", bundle: nil).instantiateViewController(identifier: "NameViewController")
        
        self.navigationController?.pushViewController(nameViewController, animated: true)
    }

}
