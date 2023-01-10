//
//  CreateViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/05.
//

import UIKit
import BSImagePicker
import Photos

class CreateModalViewController: BaseViewController {
    var selectedAssets : [PHAsset] = []

    let postUrl : PostUrl = PostUrl.shared
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
            self.convertAssetToData()
            self.viewChanged()
        })
    }
    func viewChanged() {
       
        //self.presentingViewController?.dismiss(animated: false) {
        //    print("dismiss")
        //}
        let createPostViewController = UIStoryboard(name: "ProfileStoryboard", bundle: nil).instantiateViewController(identifier: "CreatePostViewController")
        self.changeRootViewController(createPostViewController)

    }
    func convertAssetToData() {
        self.postUrl.removeAll()
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
                if (i == 0) { // 썸네일
                    let data = thumbnail.jpegData(compressionQuality: 1)
                    let newImage = UIImage(data: data!)
                    self.postUrl.thumnail = newImage
                    self.postUrl.addData(data!)
                    print("썸네일 업로드 완료")
                } else {
                    let data = thumbnail.jpegData(compressionQuality: 1)
                    self.postUrl.addData(data!)
                }
            }
        }
    }
    
}

