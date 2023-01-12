//
//  UpdatePostViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/06.
//

import UIKit
import Kingfisher
class UpdatePostViewController: BaseViewController {
    lazy var dataManager : UpdatePostDataManager = UpdatePostDataManager()
    var postRequest = UpdatePostRequest(content: "")
    let postData = PostData.shared
    let placeholder = "문구 입력..."
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postContentTextView: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("update post view will appear")
        DispatchQueue.main.async {
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
            self.profileImageView.clipsToBounds = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "정보 수정"
        self.setUI()
        // 키보드 감지
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print("update post view will disappear")
    }
    func setUI() {
        if let url = postData.postResponse?.result?.profileImgUrl {
            self.profileImageView.kf.setImage(with: URL(string: url))
        } else {
            self.profileImageView.image = UIImage(named: "default_profile")
        }
        self.userIdLabel.text = postData.postResponse?.result?.userId
        self.postImageView.kf.setImage(with: URL(string: (postData.postResponse?.result?.postImgRes[0].postImgUrl)!))
        
        self.postContentTextView.delegate = self
        self.postContentTextView.text = postData.postResponse?.result?.content
        self.postContentTextView.textColor = .black
    }
    
    @IBAction func updateButtonTouchUpInside(_ sender: UIBarButtonItem) {
        postRequest.content = postContentTextView.text
        let postIdx = (postData.postResponse?.result?.postIdx)!
        self.dataManager.updatePostData(postIdx, postRequest, delegate: self)
    }
    @objc func keyboardUp(notification:NSNotification) {
        if let keyboardFrame:NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            
            UIView.animate(
                withDuration: 0.3
                , animations: {
                    self.postContentTextView.transform = CGAffineTransform(translationX: 0, y: -keyboardRectangle.height)
                }
            )
        }
    }
    @objc func keyboardDown() {
        self.postContentTextView.transform = .identity
    }

    
}
extension UpdatePostViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || textView.text == placeholder {
            postContentTextView.textColor = .lightGray
            postContentTextView.text = placeholder
        }
    }
}

extension UpdatePostViewController {
    func didUpdatePost(result: UpdatePostResponse) {
        self.presentAlert(title: "게시물 수정에 성공하였습니다", message: result.message)
        let mainTabBarController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(identifier: "MainTabBarController")
        self.changeRootViewController(mainTabBarController)
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
