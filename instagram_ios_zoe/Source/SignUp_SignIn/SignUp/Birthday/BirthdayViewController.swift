//
//  BirthdayViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import UIKit

class BirthdayViewController: BaseViewController {
    
    private let datePicker = UIDatePicker()
    private var birthday : Date?

    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.isEnabled = true
            nextButton.backgroundColor = .buttonIsEnableTrue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        birthdayTextField.delegate = self
        self.nextButton.setCornerRadius(10)
        self.configureDatePicker()
    }
    
    // DATE PICKER
    private func configureDatePicker(){
        self.datePicker.datePickerMode = .date // 날짜만 나오게
        if #available(iOS 13.4, *) {
            self.datePicker.preferredDatePickerStyle = .wheels
        } else {
        }
        self.datePicker.locale = Locale(identifier: "ko_KR")
        self.datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
        self.birthdayTextField.inputView = self.datePicker
    }
    
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker){
        self.birthday = datePicker.date
        self.birthdayTextField.text = birthday?.koreanText
    }
    
   
    @IBAction func nextButtonTouchUpInside(_ sender: UIButton) {
        let agreementViewController = UIStoryboard(name: "SignUpStoryboard", bundle: nil).instantiateViewController(identifier: "AgreementViewController")
        self.navigationController?.pushViewController(agreementViewController, animated: true)
    }
}

extension BirthdayViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
            replacementString string: String) -> Bool {
        if (textField.text == "") {
            self.nextButton.isEnabled = false
            self.nextButton.backgroundColor = .buttonIsEnableFalse
        } else {
            self.nextButton.isEnabled = true
            self.nextButton.backgroundColor = .buttonIsEnableTrue
        }
        return true
    }
}
