//
//  FeedTableViewCell.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var idLabel2: UILabel!
    @IBOutlet weak var feedTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func get(data: Feed) {
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
        
        profileImageView.image = UIImage(named: data.profileImageName)
        idLabel.text = data.id
        feedImageView.image = UIImage(named: data.feedImageName)
        idLabel2.text = data.id
        feedTextLabel.text = data.feedText
    }
    
}
