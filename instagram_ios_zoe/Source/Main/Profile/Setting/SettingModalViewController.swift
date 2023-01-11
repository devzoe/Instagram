//
//  SettingModalViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/11.
//

import UIKit

class SettingModalViewController: UIViewController {

    @IBOutlet weak var settingView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        settingView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        let navi = self.presentingViewController?.children[4] as! UINavigationController
        let settingViewController = UIStoryboard(name: "ProfileStoryboard", bundle: nil).instantiateViewController(identifier: "SettingViewController")
        self.presentingViewController?.dismiss(animated: true) {
            print("dismiss")
            navi.pushViewController(settingViewController, animated: true)
        }
    }

}
