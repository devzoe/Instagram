//
//  CreateViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/05.
//

import UIKit
import BSImagePicker
import Photos
import FirebaseStorage
import Firebase

class CreateModalViewController: BaseViewController {
    var count = 0
    var selectedAssets : [PHAsset] = []
    var selectedImages: [UIImage] = []
    let storage = Storage.storage() //인스턴스 생성
    @IBOutlet weak var createPostView: UIView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        createPostView.addGestureRecognizer(tapGestureRecognizer)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
    // 게시물 생성
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        print("did create post tap view", sender)
        // [ImagePickerController 객체 생성 실시]
        let imagePicker = ImagePickerController()
        imagePicker.settings.theme.selectionStyle = .numbered // 이미지 선택 시 표시
        imagePicker.settings.theme.backgroundColor = .darkGray // 배경 색상
        imagePicker.albumButton.tintColor = .black // 버튼 색상
        imagePicker.cancelButton.tintColor = .black // 버튼 색상
        imagePicker.doneButton.tintColor = .black // 버튼 색상
        imagePicker.settings.theme.selectionFillColor = .black // 선택 배경 색상 (Circle)
        imagePicker.settings.theme.selectionStrokeColor = .white // 선택 표시 색상 (Circle)
        imagePicker.settings.selection.max = 10 // 최대 선택 개수
        imagePicker.settings.fetch.assets.supportedMediaTypes = [.image] // 이미지 타입
        
        // [화면 전환 실시]
        self.presentImagePicker(imagePicker, select: { (asset) in
            
        }, deselect: { (asset) in
            
        }, cancel: { (assets) in
            
        }, finish: { (assets) in
            print("선택한 이미지 개수 :: \(assets.count)")
            print("선택한 이미지 정보 :: \(assets.description)")
            
            self.selectedAssets.removeAll()
            
            for i in 0..<assets.count {
                self.selectedAssets.append(assets[i])
            }
            self.convertAssetToImages()
            print("End Did tap view")
            
            self.viewChanged()
        })
        //finish
    }
    func viewChanged() {
        UserDefaults.standard.set(count, forKey: "myImageUrlCount")
        let createPostViewController = UIStoryboard(name: "ProfileStoryboard", bundle: nil).instantiateViewController(identifier: "CreatePostNavigationController")
        self.changeRootViewController(createPostViewController)

    }
    func convertAssetToImages() {
        //초기화
        self.selectedImages.removeAll()
        if selectedAssets.count != 0 {
            
            for i in 0..<selectedAssets.count {
                
                let imageManager = PHImageManager.default()
                let option = PHImageRequestOptions()
                option.isSynchronous = true
                var thumbnail = UIImage()
                
                imageManager.requestImage(for: selectedAssets[i],
                                          targetSize: CGSize(width: 1024, height: 1024),
                                          contentMode: .aspectFit,
                                          options: option) { (result, info) in
                    thumbnail = result!
                }
                
                let data = thumbnail.pngData()
                let newImage = UIImage(data: data!)
                //print("이미지 url: ", data)
                self.selectedImages.append(newImage! as UIImage)
            }
            
            for i in 0..<selectedImages.count {
                count += 1
                FirebaseStorageManager.uploadImage(image: selectedImages[i], pathRoot: "image") { url in
                    if let url = url {
                        DispatchQueue.main.async {
                            UserDefaults.standard.set(url.absoluteString, forKey: "myImageUrl/\(i)")
                            print(UserDefaults.standard.string(forKey: "myImageUrl/\(i)") ?? "none url")
                        }
                        
                    }
                }
            }
        }
        print("End convertAssetToImages")
    }
    
}

class FirebaseStorageManager {
    static func uploadImage(image: UIImage, pathRoot: String, completion: @escaping (URL?) -> Void) {
        guard let imageData = image.pngData() else { return }
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
