//
//  FollowingTableViewCell.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/11.
//

import UIKit

class FollowingTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userIdLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func get(data: FollowingResult){
        if let url = data.profileImg {
            profileImageView.kf.setImage(with: URL(string: url))
        } else {
            profileImageView.image = UIImage(named: "고양이1")
        }
        userIdLabel.text = data.id
        if let name = data.name {
            userNameLabel.text = name
        } else {
            userNameLabel.isHidden = true
        }
    }
    @IBAction func followingButtonTouchUpInside(_ sender: UIButton) {
    }
    
}
