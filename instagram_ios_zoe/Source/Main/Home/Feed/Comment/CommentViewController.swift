//
//  CommentViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/07.
//

import UIKit
import Kingfisher

class CommentViewController: BaseViewController {
    lazy var postDataManager : MyPostDataManager = MyPostDataManager()
    var postIdx = 0
    let cellId = "CommentTableViewCell"
    @IBOutlet weak var postProfileImageView: UIImageView!
    @IBOutlet weak var postUserIdLabel: UILabel!
    @IBOutlet weak var postUpdateAt: UILabel!
    @IBOutlet weak var postContentLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBOutlet weak var commentTableView: UITableView!
    var commentList : [MyPostContents] = []
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpCommentTableView()
        self.postDataManager.getPost(postIdx, delegate: self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setUpCommentTableView() {
        self.commentTableView.delegate = self
        self.commentTableView.dataSource = self
        self.commentTableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    @IBAction func commentButtonTouchUpInside(_ sender: UIButton) {
    }
    
}
extension CommentViewController {
    func didSuccessPostData(result: MyPostResponse) {
        if let url = result.result?.profileImgUrl {
            postProfileImageView.kf.setImage(with: URL(string: url))
        } else {
            postProfileImageView.image = UIImage(named: "고양이1")
        }
        postUserIdLabel.text = result.result?.userId
        postUpdateAt.text = result.result?.updateAt
        postContentLabel.text = result.result?.content
        profileImage.image = UIImage(named: "고양이1")
        commentTextField.placeholder = "댓글 달기..."
        commentList = result.result?.postContentRes as! [MyPostContents]
        self.commentTableView.reloadData()
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}


extension CommentViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commentTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CommentTableViewCell
        let cellData = commentList[indexPath.row]
        cell.get(data: cellData)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  (commentTableView.bounds.height) * 0.15
    }
    
}
