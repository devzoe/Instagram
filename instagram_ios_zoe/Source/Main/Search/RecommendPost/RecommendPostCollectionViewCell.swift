//
//  RecommendPostCollectionViewCell.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/11.
//

import UIKit
import Kingfisher

class RecommendPostCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var postImageView : UIImageView!
    
    
    func get(data: RecommendPostResult) {
        self.postImageView.kf.setImage(with: URL(string: data.postImg))
    }
}

