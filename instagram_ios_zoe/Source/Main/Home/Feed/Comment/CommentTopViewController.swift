//
//  CommentTopViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/10.
//

import UIKit

class CommentTopViewController: UIViewController {
    lazy var postDataManager : MyPostDataManager = MyPostDataManager()
    @IBOutlet weak var postProfileImageView: UIImageView!
    @IBOutlet weak var postUserIdLabel: UILabel!
    @IBOutlet weak var postUpdateAt: UILabel!
    @IBOutlet weak var postContentLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.async {
            self.postProfileImageView.layer.cornerRadius = self.postProfileImageView.frame.width / 2
            self.postProfileImageView.clipsToBounds = true
        }
        let postIdx = UserDefaults.standard.integer(forKey: "postIdx")
        self.postDataManager.getPostInCommentTop(postIdx, delegate: self)
    }
    

}

extension CommentTopViewController {
    func didSuccessPostData(result: MyPostResponse) {
        if let url = result.result?.profileImgUrl {
            postProfileImageView.kf.setImage(with: URL(string: url))
        } else {
            postProfileImageView.image = UIImage(named: "고양이1")
        }
        postUserIdLabel.text = result.result?.userId
        postUpdateAt.text = result.result?.updateAt
        postContentLabel.text = result.result?.content
        
    }
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
