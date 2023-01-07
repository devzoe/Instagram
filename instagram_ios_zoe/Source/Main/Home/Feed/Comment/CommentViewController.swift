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
    lazy var commentDataManager : CommentDataManager = CommentDataManager()
    var postIdx = 0
    let cellId = "CommentTableViewCell"
    @IBOutlet weak var postProfileImageView: UIImageView!
    @IBOutlet weak var postUserIdLabel: UILabel!
    @IBOutlet weak var postUpdateAt: UILabel!
    @IBOutlet weak var postContentLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var footerView: UIView!
    
    
    var commentList : [MyPostContents] = []
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpCommentTableView()
        self.postDataManager.getPost(postIdx, delegate: self)
        
        // 키보드 감지
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Dismiss Keyboard When Tapped Arround
        self.dismissKeyboardWhenTappedAround()
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setUpCommentTableView() {
        self.commentTableView.delegate = self
        self.commentTableView.dataSource = self
        self.commentTableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    @objc func keyboardUp(notification:NSNotification) {
        if let keyboardFrame:NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            
            UIView.animate(
                withDuration: 0.3
                , animations: {
                    self.footerView.transform = CGAffineTransform(translationX: 0, y: -keyboardRectangle.height)
                }
            )
        }
    }
    @objc func keyboardDown() {
        self.footerView.transform = .identity
    }
    
    @IBAction func commentButtonTouchUpInside(_ sender: UIButton) {
        let reply = commentTextField.text
        let commentRequest = CommentRequest(reply: reply!, depth: 0, commentAIdx: 0)
        commentDataManager.postComment(postIdx, commentRequest, delegate: self)
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
    func didSuccessComment() {
        // 댓글 생성 성공.
        self.commentTableView.reloadData()
    }
    func didDeleteComment() {
        // 댓글 생성 성공.
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let commentIdx = commentList[indexPath.row].postCommentIdx
            commentDataManager.deleteComment(commentIdx, delegate: self)
        } else if editingStyle == .insert {
        }
    }
    
}
