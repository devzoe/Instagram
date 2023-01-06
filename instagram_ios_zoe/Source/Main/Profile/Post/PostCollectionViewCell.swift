//
//  PostCollectionViewCell.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/05.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var postThumbnailImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func get(data: ProfilePostImg) {
        let urlString = data.postImgUrl
        postThumbnailImageView.kf.setImage(with: URL(string: urlString))
    }

}
