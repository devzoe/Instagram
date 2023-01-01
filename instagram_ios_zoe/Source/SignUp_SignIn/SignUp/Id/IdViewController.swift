//
//  NicknameViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import UIKit

class IdViewController: BaseViewController {

    @IBOutlet weak var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextButton.setCornerRadius(10)
        
    }
    
    @IBAction func nextButtonTouchUpInside(_ sender: UIButton) {
        let finalViewController = UIStoryboard(name: "SignUpStoryboard", bundle: nil).instantiateViewController(identifier: "FinalViewController")
        
        self.navigationController?.pushViewController(finalViewController, animated: true)
    }

    
}
