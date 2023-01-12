//
//  CreatePostViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/04.
//

import UIKit
import Kingfisher
import FirebaseStorage
import Firebase

class CreatePostViewController: UIViewController {
    lazy var dataManager: CreatePostDataManager = CreatePostDataManager()
    let postUrl : PostUrl = PostUrl.shared
    var postRequest : PostRequest = PostRequest(content: "", postImgReqs: [])
    let placeholder = "문구 입력..."
    @IBOutlet weak var postThumbnailImageView: UIImageView!
    @IBOutlet weak var postContentTextView: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("create view will appear")
        // 이미지 업로드
        for i in 0..<self.postUrl.dataCount() {
            FirebaseStorageManager.uploadImage(imageData: self.postUrl.readData(at: i), pathRoot: "image") { url in
                if let url = url {
                    let urlString = url.absoluteString
                    self.postRequest.postImgReqs.append(PostImageReqs(postImgUrl: urlString))
                    print("url add", urlString)
                }
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("create view did appear")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationBar.topItem?.title = "새 게시물"
        print("create post view did load")
        self.postThumbnailImageView.image = postUrl.thumnail
        
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
        postRequest.content = postContentTextView.text
        print("문구 : ", postRequest.content)
        print("이미지 : ", postRequest.postImgReqs)
        
        dataManager.postData(postRequest, delegate: self)
    }
    
    @IBAction func backButtonTouchUpInside(_ sender: UIButton) {
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
        //self.presentAlert(title: "게시물 업로드에 성공하였습니다", message: "")
        let mainTabBarController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(identifier: "MainTabBarController")
        self.changeRootViewController(mainTabBarController)
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}

class FirebaseStorageManager {
    static func uploadImage(imageData: Data, pathRoot: String, completion: @escaping (URL?) -> Void) {
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        let imageName = UUID().uuidString + String(Date().timeIntervalSince1970)
        let firebaseReference = Storage.storage().reference().child("\(imageName)")
        firebaseReference.putData(imageData, metadata: metaData) { metaData, error in
            firebaseReference.downloadURL { url, _ in
                completion(url)
            }
        }
    }
    static func downloadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        let storageReference = Storage.storage().reference(forURL: urlString)
        let megaByte = Int64(1 * 1024 * 1024)
        
        storageReference.getData(maxSize: megaByte) { data, error in
            guard let imageData = data else {
                completion(nil)
                return
            }
            completion(UIImage(data: imageData))
        }
    }
}
