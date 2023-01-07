//
//  PostDetailViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/06.
//

import UIKit

class PostDetailViewController: UIViewController {
    var postResponse: MyPostResponse = MyPostResponse(isSuccess: false, code: 0, message: "", result: nil)
    @IBOutlet weak var navigationTitle: UINavigationItem!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userIdLabel: UILabel!
    
    @IBOutlet weak var userIdLabel2: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var postImageScrollView: UIScrollView!
    @IBOutlet weak var postImagePageControl: UIPageControl!
    @IBOutlet weak var viewInScrollView: UIView!
    
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var menuButton: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpUI()

    }
    func setUpUI() {
        self.navigationTitle.title = "게시물"
        if let profileImage = postResponse.result?.profileImgUrl {
            self.profileImageView.kf.setImage(with: URL(string: profileImage))
        } else {
            self.profileImageView.image = UIImage(named: "고양이1")
        }
        self.userIdLabel.text = postResponse.result?.userId
        self.userIdLabel2.text = postResponse.result?.userId
        self.contentLabel.text = postResponse.result?.content
    }
    @IBAction func backButtonTouchUpInside(_ sender: UIButton) {
    }
    
    @IBAction func menuButtonTouchUpInside(_ sender: UIButton) {
        let deletePostViewController = self.storyboard?.instantiateViewController(identifier: "DeletePostViewController") as! DeletePostViewController
        deletePostViewController.postIdx = postResponse.result!.postIdx
        self.present(deletePostViewController, animated: true, completion: nil)
        
    }
    
}
