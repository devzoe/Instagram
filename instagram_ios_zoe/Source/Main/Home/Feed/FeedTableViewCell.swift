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
    func commentLabelTapped(postIdx : Int)
}
class FeedTableViewCell: UITableViewCell, UIScrollViewDelegate {
    var delegate: FeedCellDelegate?
    var postImgRes: [FeedPostImages] = []
    var cellHeight: CGFloat = 0
    var postIdx = 0
    var tapGestureRecognizer : UITapGestureRecognizer!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var idLabel2: UILabel!
    @IBOutlet weak var feedTextLabel: UILabel!
    
    @IBOutlet weak var feedImagePageControl: UIPageControl!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var updateAtLabel: UILabel!
    
    @IBOutlet weak var imageScrollView: UIScrollView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didCommentTapped(_:)))
        self.commentCountLabel.addGestureRecognizer(tapGestureRecognizer)
        imageScrollView.delegate = self
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
            self.feedImagePageControl.pageIndicatorTintColor = .buttonGray
            self.feedImagePageControl.currentPageIndicatorTintColor = .buttonIsEnableTrue
            self.addContentScrollView(data.postImgRes)
            self.setPageControl(data.postImgRes)
        }
        
        // 프로필 이미지
        if let url = data.profileImgUrl {
            let profileImgUrl = URL(string: url)
            profileImageView.kf.setImage(with: profileImgUrl)
        } else {
            profileImageView.image = UIImage(named: "default_profile")
        }

        // user id
        idLabel.text = data.userId
        idLabel2.text = data.userId
        feedTextLabel.text = data.content
        // 좋아요
        
        let likeCount = "좋아요 \(data.postLikeCount)개"
        likeCountLabel.text = likeCount
        let commentCount = "댓글 \(data.commentCount)개 모두 보기"
        commentCountLabel.text = commentCount
        updateAtLabel.text = data.updateAt
    }
    private func addContentScrollView(_ imageResult : [FeedPostImages]) {
        var index = imageResult.count - 1
        for i in 0..<imageResult.count {
            let imageView = UIImageView()
            let xPos = imageScrollView.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0, width: imageScrollView.bounds.width, height: imageScrollView.bounds.height)
            imageView.kf.setImage(with: URL(string: imageResult[index].postImgUrl))
            imageScrollView.addSubview(imageView)
            imageScrollView.contentSize.width = imageView.frame.width * CGFloat(i + 1)
            index -= 1
        }
        
    }
    private func setPageControl(_ imageResult : [FeedPostImages]) {
        feedImagePageControl.numberOfPages = imageResult.count
        
    }
    
    private func setPageControlSelectedPage(currentPage:Int) {
        feedImagePageControl.currentPage = currentPage
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = (scrollView.contentOffset.x)/(scrollView.frame.size.width)
        setPageControlSelectedPage(currentPage: Int(round(value)))
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageScrollView.subviews.forEach{
            $0.removeFromSuperview()
        }
    }
}

