//
//  PostTableViewCell.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/09.
//

import UIKit
import Kingfisher

// 델리게이트
protocol PostCellDelegate {
    func imagePageChanged(pageControl : UIPageControl, postImgRes: [MyPostImages], imageView: UIImageView)
    func commentLabelTapped(postIdx : Int)
    func menuButtonTapped()
}
class PostTableViewCell: UITableViewCell {
    var delegate: PostCellDelegate?
    var postImgRes: [MyPostImages] = []
    var cellHeight: CGFloat = 0
    var postIdx = 0
    var tapGestureRecognizer : UITapGestureRecognizer!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var userIdLabel2: UILabel!
    @IBOutlet weak var postPageControl: UIPageControl!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var updateAtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didCommentTapped(_:)))
       // self.commentCountLabel.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func didCommentTapped(_ sender: UITapGestureRecognizer) {
        print("did comment tapped", sender)
        self.delegate?.commentLabelTapped(postIdx: postIdx)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func get(data: MyPostResult) {
        DispatchQueue.main.async {
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
            self.profileImageView.clipsToBounds = true
        }
        postPageControl.numberOfPages = data.postImgRes.count
        postPageControl.currentPage = 0
        postPageControl.pageIndicatorTintColor = .lightGray
        postPageControl.currentPageIndicatorTintColor = .buttonIsEnableTrue
        
        // 프로필 이미지
        if let url = data.profileImgUrl {
            let profileImgUrl = URL(string: url)
            profileImageView.kf.setImage(with: profileImgUrl)
        } else {
            profileImageView.image = UIImage(named: "고양이1")
        }

        // user id
        userIdLabel.text = data.userId
        
        //피드 이미지
        let feedImgUrl = URL(string: data.postImgRes[0].postImgUrl)
        postImageView.kf.setImage(with: feedImgUrl)
        
        
        userIdLabel2.text = data.userId
        contentLabel.text = data.content
        // 좋아요
        
        let likeCount = "좋아요 \(data.postLikeCount)개"
        likeCountLabel.text = likeCount
        //let commentCount = "댓글 \(data.commentCount)개 모두 보기"
       // commentCountLabel.text = commentCount
        commentCountLabel.isHidden = true
        updateAtLabel.text = data.updateAt
    }
    
    @IBAction func imagePageChanged(_ sender: UIPageControl) {
        print("pageChanged")
        self.delegate?.imagePageChanged(pageControl: sender, postImgRes: postImgRes, imageView: postImageView)
    }
    
    @IBAction func menuButtonTouchUpInside(_ sender: UIButton) {
        self.delegate?.menuButtonTapped()
    }
    
}


