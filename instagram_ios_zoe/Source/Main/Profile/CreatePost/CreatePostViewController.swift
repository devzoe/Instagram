//
//  CreatePostViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/04.
//

import UIKit
import Kingfisher

class CreatePostViewController: UIViewController {
    lazy var dataManager: CreatePostDataManager = CreatePostDataManager()
    var postRequest : PostRequest = PostRequest(content: "", postImgReqs: [])
    var count = 0
    let placeholder = "문구 입력..."
    @IBOutlet weak var postThumbnailImageView: UIImageView!
    @IBOutlet weak var postContentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "새 게시물"
        //postRequest.postImgReqs.append(PostImageReqs(postImgUrl: ""))
        DispatchQueue.main.async {
            self.postThumbnailImageView.kf.setImage(with: URL(string: UserDefaults.standard.string(forKey: "myImageUrl/0")!))
        }
        
        setupTextView()
    }
    
    func setupTextView() {
        postContentTextView.delegate = self
        postContentTextView.text = placeholder
        postContentTextView.textColor = .lightGray
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func postButtonTouchUpInside(_ sender: Any) {
        
        let count = UserDefaults.standard.integer(forKey: "myImageUrlCount")
        print(count)
        for i in 0..<count {
            postRequest.postImgReqs.append(PostImageReqs(postImgUrl:UserDefaults.standard.string(forKey: "myImageUrl/\(i)")!))
            print("유저 디폴트 : ",UserDefaults.standard.string(forKey: "myImageUrl/\(i)")!)
            print("이미지 url : \(i)", postRequest.postImgReqs[i].postImgUrl)
        }
        postRequest.content = postContentTextView.text
        print("문구 : ", postRequest.content)
        print("이미지 : ", postRequest.postImgReqs)
        
        dataManager.postData(postRequest, delegate: self)
    }
    
}

extension CreatePostViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        postContentTextView.textColor = .black
        postContentTextView.text = nil
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || textView.text == placeholder {
            postContentTextView.textColor = .lightGray
            postContentTextView.text = placeholder
        }
    }
}

extension CreatePostViewController {
    func didSuccessPost() {
        self.presentAlert(title: "게시물 업로드에 성공하였습니다", message: "")
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
