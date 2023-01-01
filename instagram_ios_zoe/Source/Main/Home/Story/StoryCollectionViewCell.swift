//
//  StoryCollectionViewCell.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var storyProfileImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    public func get(data: Story) {
        storyProfileImage.layer.cornerRadius = storyProfileImage.frame.width / 2
        storyProfileImage.clipsToBounds = true
        
        storyProfileImage.image = UIImage(named: data.profileImageName)
        idLabel.text = data.id
    }
}
