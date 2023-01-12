//
//  PostDetailViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/06.
//

import UIKit

class PostDetailViewController: BaseViewController {
    var postResponse: MyPostResponse = MyPostResponse(isSuccess: false, code: 0, message: "", result: nil)
    let cellId = "PostTableViewCell"
    @IBOutlet weak var postTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpTableView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //DispatchQueue.main.async {
         //   self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
         //   self.profileImageView.clipsToBounds = true
        //}
    }
    func setUpTableView(){
        self.postTableView.delegate = self
        self.postTableView.dataSource = self
        self.postTableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
}

extension PostDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PostTableViewCell
        let cellData = postResponse.result!
        cell.get(data: cellData)
        cell.postImgRes = cellData.postImgRes
        cell.postIdx = cellData.postIdx
        cell.selectionStyle = .none
        cell.delegate = self
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  (postTableView.bounds.height) * 1
    }
}
extension PostDetailViewController: PostCellDelegate {
    func commentLabelTapped(postIdx: Int) {
        let comment = UIStoryboard.init(name: "HomeStoryboard", bundle: nil)
        let commentViewController = comment.instantiateViewController(withIdentifier: "CommentViewController") as! CommentViewController
        commentViewController.postIdx = postIdx
        UserDefaults.standard.set(postIdx, forKey: "postIdx")
        self.navigationController?.pushViewController(commentViewController, animated: true)
    }
    func menuButtonTapped() {
        let deletePostViewController = self.storyboard?.instantiateViewController(identifier: "DeletePostViewController") as! DeletePostViewController
        deletePostViewController.postIdx = postResponse.result!.postIdx
        self.present(deletePostViewController, animated: true, completion: nil)
    }
}
