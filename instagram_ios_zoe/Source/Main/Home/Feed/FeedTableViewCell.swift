//
//  FeedTableViewCell.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import UIKit
import Kingfisher

// 페이지 컨트롤 델리게이트
protocol PageControlDelegate {
    func imagePageChanged(pageControl : UIPageControl, postImgRes: [PostImages], imageView: UIImageView)
}

class FeedTableViewCell: UITableViewCell {
    var delegate: PageControlDelegate?
    var postImgRes: [PostImages] = []
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var idLabel2: UILabel!
    @IBOutlet weak var feedTextLabel: UILabel!
    
    @IBOutlet weak var feedImagePageControl: UIPageControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func get(data: FeedResult) {
        DispatchQueue.main.async {
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
            self.profileImageView.clipsToBounds = true
        }
        feedImagePageControl.numberOfPages = data.postImgRes.count
        feedImagePageControl.currentPage = 0
        feedImagePageControl.pageIndicatorTintColor = .lightGray
        feedImagePageControl.currentPageIndicatorTintColor = .blue
        
        // 프로필 이미지
        if let url = data.profileImgUrl {
            let profileImgUrl = URL(string: url)
            profileImageView.kf.setImage(with: profileImgUrl)
        } else {
            profileImageView.image = UIImage(named: "고양이1")
        }

        // user id
        idLabel.text = data.userId
        
        //피트 이미지
        let feedImgUrl = URL(string: data.postImgRes[0].postImgUrl)
        feedImageView.kf.setImage(with: feedImgUrl)
        idLabel2.text = data.userId
        feedTextLabel.text = data.content
        
    }
    
    @IBAction func imagePageChanged(_ sender: UIPageControl) {
        print("pageChanged")
        self.delegate?.imagePageChanged(pageControl: sender, postImgRes: postImgRes, imageView: feedImageView)
    }
    
    
}
