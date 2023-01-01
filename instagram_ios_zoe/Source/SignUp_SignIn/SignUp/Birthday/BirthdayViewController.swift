//
//  BirthdayViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import UIKit

class BirthdayViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextButton.setCornerRadius(10)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonTouchUpInside(_ sender: UIButton) {
        let agreementViewController = UIStoryboard(name: "SignUpStoryboard", bundle: nil).instantiateViewController(identifier: "AgreementViewController")
        
        self.navigationController?.pushViewController(agreementViewController, animated: true)
    }
    

}
