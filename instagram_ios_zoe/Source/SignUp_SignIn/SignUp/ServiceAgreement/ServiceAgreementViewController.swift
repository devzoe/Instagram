//
//  ServiceAgreementViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import UIKit

class ServiceAgreementViewController: BaseViewController {

    @IBOutlet weak var allCheckBox: UIButton!
    @IBOutlet weak var termsOfServiceCheckBox: UIButton!
    @IBOutlet weak var dataPolicyCheckBox: UIButton!
    @IBOutlet weak var locationCheckBox: UIButton!
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.isEnabled = false
            nextButton.backgroundColor = .buttonIsEnableFalse
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextButton.setCornerRadius(10)
    }
    
    private func checkIsSelected() {
        if (termsOfServiceCheckBox.isSelected
            && dataPolicyCheckBox.isSelected && locationCheckBox.isSelected) {
            self.nextButton.isEnabled = true
            self.nextButton.backgroundColor = .buttonIsEnableTrue
        } else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = .buttonIsEnableFalse
        }
    }
    @IBAction func allCheckBoxTouchUpInside(_ sender: UIButton) {
        sender.isSelected = true
        termsOfServiceCheckBox.isSelected = true
        dataPolicyCheckBox.isSelected = true
        locationCheckBox.isSelected = true
        
        if (sender.isSelected && termsOfServiceCheckBox.isSelected
            && dataPolicyCheckBox.isSelected && locationCheckBox.isSelected) {
            sender.tintColor = .buttonIsEnableTrue
            termsOfServiceCheckBox.tintColor = .buttonIsEnableTrue
            dataPolicyCheckBox.tintColor = .buttonIsEnableTrue
            locationCheckBox.tintColor = .buttonIsEnableTrue
        }
        checkIsSelected()
        
    }
    
    @IBAction func termsOfServiceCheckBoxTouchUpInside(_ sender: UIButton) {
        sender.isSelected.toggle()
        if (sender.isSelected) {
            sender.tintColor = .buttonIsEnableTrue
        } else {
            sender.tintColor = .buttonIsEnableFalse
            allCheckBox.isSelected = false
            allCheckBox.tintColor = .buttonIsEnableFalse
            
        }
        checkIsSelected()
    }
    @IBAction func dataPolicyCheckBoxTouchUpInside(_ sender: UIButton) {
        sender.isSelected.toggle()
        if (sender.isSelected) {
            sender.tintColor = .buttonIsEnableTrue
        } else {
            sender.tintColor = .buttonIsEnableFalse
            allCheckBox.isSelected = false
            allCheckBox.tintColor = .buttonIsEnableFalse
        }
        checkIsSelected()
    }
    
    @IBAction func locationCheckBoxTouchUpInside(_ sender: UIButton) {
        sender.isSelected.toggle()
        if (sender.isSelected) {
            sender.tintColor = .buttonIsEnableTrue
        } else {
            sender.tintColor = .buttonIsEnableFalse
            allCheckBox.isSelected = false
            allCheckBox.tintColor = .buttonIsEnableFalse
        }
        checkIsSelected()
    }
    @IBAction func nextButtonTouchUpInside(_ sender: UIButton) {
        let nicknameViewController = UIStoryboard(name: "SignUpStoryboard", bundle: nil).instantiateViewController(identifier: "IdViewController")
        self.navigationController?.pushViewController(nicknameViewController, animated: true)
    }
    
    
}
