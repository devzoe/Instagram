//
//  FeedTableViewCell.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import UIKit
import Kingfisher

// 페이지 컨트롤 델리게이트
protocol FeedCellDelegate {
    func imagePageChanged(pageControl : UIPageControl, postImgRes: [FeedPostImages], imageView: UIImageView)
    func commentLabelTapped(postIdx : Int)
}


class FeedTableViewCell: UITableViewCell {
    var delegate: FeedCellDelegate?
    var postImgRes: [FeedPostImages] = []
    var cellHeight: CGFloat = 0
    var postIdx = 0
    var tapGestureRecognizer : UITapGestureRecognizer!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var feedImageView: UIImageView!
    
    @IBOutlet weak var idLabel2: UILabel!
    @IBOutlet weak var feedTextLabel: UILabel!
    
    @IBOutlet weak var feedImagePageControl: UIPageControl!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var updateAtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didCommentTapped(_:)))
        self.commentCountLabel.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func didCommentTapped(_ sender: UITapGestureRecognizer) {
        print("did comment tapped", sender)
        self.delegate?.commentLabelTapped(postIdx: postIdx)
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
        feedImagePageControl.currentPageIndicatorTintColor = .buttonIsEnableTrue
        
        // 프로필 이미지
        if let url = data.profileImgUrl {
            let profileImgUrl = URL(string: url)
            profileImageView.kf.setImage(with: profileImgUrl)
        } else {
            profileImageView.image = UIImage(named: "고양이1")
        }

        // user id
        idLabel.text = data.userId
        
        //피드 이미지
        let feedImgUrl = URL(string: data.postImgRes[0].postImgUrl)
        feedImageView.kf.setImage(with: feedImgUrl)
        
        
        idLabel2.text = data.userId
        feedTextLabel.text = data.content
        // 좋아요
        
        let likeCount = "좋아요 \(data.postLikeCount)개"
        likeCountLabel.text = likeCount
        let commentCount = "댓글 \(data.commentCount)개 모두 보기"
        commentCountLabel.text = commentCount
        updateAtLabel.text = data.updateAt
    }
    
    @IBAction func imagePageChanged(_ sender: UIPageControl) {
        print("pageChanged")
        self.delegate?.imagePageChanged(pageControl: sender, postImgRes: postImgRes, imageView: feedImageView)
    }
}

