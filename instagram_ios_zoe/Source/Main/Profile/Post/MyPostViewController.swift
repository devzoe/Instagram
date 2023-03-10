//
//  MyPostViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/03.
//

import UIKit

class MyPostViewController: BaseViewController {
    lazy var dataManager: ProfileDataManager = ProfileDataManager()
    lazy var postDataManager: MyPostDataManager = MyPostDataManager()
    let postData = PostData.shared
    var postResponse: MyPostResponse = MyPostResponse(isSuccess: false, code: 0, message: "", result: nil)
    let cellMarginSize: CGFloat = 1
    let postCell = "PostCollectionViewCell"

    
    var posts : [ProfilePostImg]?
    @IBOutlet weak var postCollectionView: UICollectionView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.dataManager.getMyPostData(delegate: self)
            self.setupPostColletionView()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.dataManager.getMyPostData(delegate: self)
        
        //setupPostColletionView()
        
    }
    private func setupPostColletionView() {
        postCollectionView.register(UINib(nibName: postCell, bundle: nil), forCellWithReuseIdentifier: postCell)
        postCollectionView.delegate = self
        postCollectionView.dataSource = self
    }
}

extension MyPostViewController {
    func didSetPost(result: ProfileResult) {
        if result.profilePostImgs != nil {
            //self.presentAlert(title: "사진 로딩에 성공하였습니다", message: result.profilePostImgs![0].postImgUrl)
            posts = result.profilePostImgs!
            postCollectionView.reloadData()
        }
    }
    func didSuccessPostDetail(result: MyPostResponse) {
        //self.presentAlert(title: "게시물 로딩에 성공하였습니다", message: result.message)
        postResponse = result
        postData.add(postResponse)
        let postDetailViewController = storyboard?.instantiateViewController(withIdentifier: "PostDetailViewController") as! PostDetailViewController
        postDetailViewController.postResponse = postResponse
        self.navigationController?.pushViewController(postDetailViewController, animated: true)
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}

extension MyPostViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print(indexPath.row)
        let postIdx = posts![indexPath.row].postIdx
        postDataManager.getPostData(postIdx, delegate: self)
    }
    
}

extension MyPostViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postCell , for: indexPath) as! PostCollectionViewCell

        let cellData = posts![indexPath.row]
        cell.get(data: cellData)
       
        return cell
    }
    
}

extension MyPostViewController: UICollectionViewDelegateFlowLayout {
    
    // 셀 크기 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let numberOfItemsPerRow: CGFloat = 3
        let spacing: CGFloat = self.cellMarginSize
        let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
        let itemDimension = availableWidth / numberOfItemsPerRow

        return CGSize(width: itemDimension, height: itemDimension)
    }
    // 섹션에서 콘텐츠를 배치하는 데 사용되는 여백
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    // 그리드의 항목 줄 사이에 사용할 최소 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.cellMarginSize
    }
    // 같은 행에 있는 항목 사이에 사용할 최소 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
