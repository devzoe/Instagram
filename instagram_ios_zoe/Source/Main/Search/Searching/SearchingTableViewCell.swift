//
//  SearchingTableViewCell.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/07.
//

import UIKit
import Kingfisher

class SearchingTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        DispatchQueue.main.async {
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
            self.profileImageView.clipsToBounds = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func get(data : SearchResult) {
        if let url = data.img {
            profileImageView.kf.setImage(with: URL(string: url))
        } else {
            profileImageView.image = UIImage(named: "default_profile")
        }
        userIdLabel.text = data.name
        userNameLabel.text = data.detail
    }
    
}
