//
//  CommentTableViewCell.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/07.
//

import UIKit
import Kingfisher
class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userIdLabel: UILabel!
    
    @IBOutlet weak var replyLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func get(data: MyPostContents) {
        if let url = data.profileImg {
            profileImageView.kf.setImage(with: URL(string: url))
        } else {
            profileImageView.image = UIImage(named: "고양이1")
        }
        userIdLabel.text = data.userId
        replyLabel.text = data.reply
        
    }
}
