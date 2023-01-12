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
    var postResponse = MyPostResponse(isSuccess: false, code: 0, message: "", result: nil)
    var postIdx = 0
    let cellId = "CommentTableViewCell"
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var footerView: UIView!
    
    var commentList : [MyPostContents] = []
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.profileImage.layer.cornerRadius = self.profileImage.frame.width / 2
            self.profileImage.clipsToBounds = true
        }
        
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
        self.commentTableView.register(CommentHeaderView.self, forHeaderFooterViewReuseIdentifier: CommentHeaderView.headerViewID)
        self.commentTableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    @objc func keyboardUp(notification:NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        let keyboardHeight = keyboardSize.height
        self.view.frame.origin.y -= (keyboardHeight-(self.tabBarController?.tabBar.frame.size.height)!)
    }
    @objc func keyboardDown(_ notification: Notification) {
        self.view.frame.origin.y = 0
    }
    
    @IBAction func commentButtonTouchUpInside(_ sender: UIButton) {
        let reply = commentTextField.text
        let commentRequest = CommentRequest(reply: reply!, depth: 0, commentAIdx: 0)
        commentTextField.text = ""
        commentDataManager.postComment(postIdx, commentRequest, delegate: self)
    }
}
extension CommentViewController : UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
        return true
    }
}
extension CommentViewController {
    func didSuccessPostData(result: MyPostResponse) {
        postResponse = result
        profileImage.image = UIImage(named: "default_profile")
        commentTextField.placeholder = "댓글 달기..."
        commentList = result.result?.postContentRes as! [MyPostContents]
        self.commentTableView.reloadData()
    }
    func didSuccessComment() {
        // 댓글 생성 성공.
        self.postDataManager.getPost(postIdx, delegate: self)

    }
    func didDeleteComment() {
        // 댓글 삭제 성공.
        self.postDataManager.getPost(postIdx, delegate: self)

    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}


extension CommentViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commentTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CommentTableViewCell
        if indexPath.section == 0 {
            let cellData = commentList[indexPath.row]
            cell.get(data: cellData)
            cell.selectionStyle = .none
        }
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
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        guard section == 0, let commentHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CommentHeaderView.headerViewID) as? CommentHeaderView else {
            return UIView()
        }
        
        if let url = postResponse.result?.profileImgUrl {
            commentHeaderView.postProfileImageView.kf.setImage(with: URL(string: url))
        } else {
            commentHeaderView.postProfileImageView.image = UIImage(named: "default_profile")
        }
        
        commentHeaderView.userIdLabel.text = postResponse.result?.userId
        commentHeaderView.updateAtLabel.text = postResponse.result?.updateAt
        commentHeaderView.contentLabel.text = postResponse.result?.content
        
        return commentHeaderView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
}
