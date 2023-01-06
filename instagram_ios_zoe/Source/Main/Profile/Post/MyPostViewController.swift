//
//  MyPostViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/03.
//

import UIKit

class MyPostViewController: UIViewController {
    lazy var dataManager: ProfileDataManager = ProfileDataManager()
    let cellMarginSize: CGFloat = 1
    let postCell = "PostCollectionViewCell"
    
    var posts : [ProfilePostImg]?
    @IBOutlet weak var postCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dataManager.getMyPostData(delegate: self)
        
        setupPostColletionView()
        
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
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}

extension MyPostViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print(indexPath.row)
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
        let itemDimension = floor(availableWidth / numberOfItemsPerRow)

        return CGSize(width: itemDimension, height: itemDimension)
    }
    // 섹션에서 콘텐츠를 배치하는 데 사용되는 여백
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    
    // 그리드의 항목 줄 사이에 사용할 최소 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.cellMarginSize
    }

    // 같은 행에 있는 항목 사이에 사용할 최소 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.cellMarginSize
    }
}
