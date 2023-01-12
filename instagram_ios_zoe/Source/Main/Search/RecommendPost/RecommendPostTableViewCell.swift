//
//  RecommendPostTableViewCell.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/12.
//

import UIKit
import Kingfisher

class RecommendPostTableViewCell: UITableViewCell, UIScrollViewDelegate {
    var imageViews = [UIImageView]()
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var userIdLabel2: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var updateAtLabel: UILabel!
    
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var imagePageControll: UIPageControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageScrollView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func get(data : RecommendFeedResult) {
        DispatchQueue.main.async {
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
            self.profileImageView.clipsToBounds = true
            if let url = data.profileImgUrl {
                self.profileImageView.kf.setImage(with: URL(string: url))
            } else {
                self.profileImageView.image = UIImage(named: "default_profile")
            }
            self.imagePageControll.pageIndicatorTintColor = .buttonGray
            self.imagePageControll.currentPageIndicatorTintColor = .buttonIsEnableTrue
            self.userIdLabel.text = data.userId
            let like = data.postLikeCount
            self.likeCountLabel.text = "좋아요 \(like)개"
            self.userIdLabel2.text = data.userId
            self.contentLabel.text = data.content
            self.updateAtLabel.text = data.updateAt
            
            self.addContentScrollView(data.postImgRes)
            self.setPageControl(data.postImgRes)
        }
        
    }
    
    private func addContentScrollView(_ imageResult : [PostImgRes]) {

        var index = imageResult.count - 1
        for i in (0..<imageResult.count) {
            let imageView = UIImageView()
            let xPos = imageScrollView.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0, width: imageScrollView.bounds.width, height: imageScrollView.bounds.height)
            imageView.kf.setImage(with: URL(string: imageResult[index].postImgUrl))
            imageScrollView.addSubview(imageView)
            imageScrollView.contentSize.width = imageView.frame.width * CGFloat(i + 1)
            index -= 1
        }
        
    }
    
    private func setPageControl(_ imageResult : [PostImgRes]) {
        imagePageControll.numberOfPages = imageResult.count
    }
    private func setPageControlSelectedPage(currentPage:Int) {
        imagePageControll.currentPage = currentPage
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x/scrollView.frame.size.width
        setPageControlSelectedPage(currentPage: Int(round(value)))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageScrollView.subviews.forEach{
            $0.removeFromSuperview()
        }
    }
}
