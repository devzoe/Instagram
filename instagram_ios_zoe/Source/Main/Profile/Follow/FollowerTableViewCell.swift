//
//  FollowerTableViewCell.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/11.
//

import UIKit
import Kingfisher

class FollowerTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userIdLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        DispatchQueue.main.async {
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
            self.profileImageView.clipsToBounds = true
            
            self.deleteButton.setCornerRadius(10)
        }

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func get(data: FollowerResult){
        if let url = data.profileImg {
            profileImageView.kf.setImage(with: URL(string: url))
        } else {
            profileImageView.image = UIImage(named: "default_profile")
        }
        userIdLabel.text = data.id
        if let name = data.name {
            userNameLabel.text = name
        } else {
            userNameLabel.isHidden = true
        }
    }

    @IBAction func deleteButtonTouchUpInside(_ sender: Any) {
    }
}
