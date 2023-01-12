//
//  StoryViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import UIKit

class StoryViewController: BaseViewController {
    
    let sectionInsets = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    
    lazy var dataManager: StoryDataManager = StoryDataManager()
    
    let storyCell = "StoryCollectionViewCell"
    
    var stories : [Story] = []
    
    @IBOutlet weak var storyCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStoryCollectionView()
        dataManager.getStoryList(delegate: self)

    }
    
    private func setupStoryCollectionView() {
        storyCollectionView.register(UINib(nibName: storyCell, bundle: nil), forCellWithReuseIdentifier: storyCell)
        storyCollectionView.delegate = self
        storyCollectionView.dataSource = self
    }
}

extension StoryViewController {
        func didSetStory(result: StoryResponse) {
            stories = result.storyList
            storyCollectionView.reloadData()
        }
        
        func failedToRequest(message: String) {
            self.presentAlert(title: message)
        }
}

extension StoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = storyCollectionView.dequeueReusableCell(
            withReuseIdentifier: storyCell,
            for: indexPath) as! StoryCollectionViewCell
    
        let cellData = stories[indexPath.row]
        cell.get(data: cellData)

        return cell
    }

    //cell 크기
    private func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = Device.width / 4
        let height = collectionView.frame.height - 10
              
        return CGSize(width: width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 같은 행에 있는 항목 사이에 사용할 최소 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
