//
//  FeedViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/02.
//

import UIKit

class FeedViewController: BaseViewController {
    lazy var dataManager: FeedDataManager = FeedDataManager()
    
    let feedCell = "FeedTableViewCell"
    
    var feeds : [FeedResult] = []
    
    @IBOutlet weak var feedTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //DispatchQueue.main.async {
            self.setupFeedTableView()
            self.dataManager.getFeedData(delegate: self)
        //}
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func setupFeedTableView() {
        feedTableView.register(
            UINib(nibName: feedCell, bundle: nil),
            forCellReuseIdentifier: feedCell
        )
        feedTableView.delegate = self
        feedTableView.dataSource = self
        //feedTableView.rowHeight = UITableView.automaticDimension
        feedTableView.estimatedRowHeight = UITableView.automaticDimension
    }

}
extension FeedViewController {
    func didSetFeed(result: FeedResponse) {
        feeds = result.result!
        feedTableView.reloadData()
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = feedTableView.dequeueReusableCell(withIdentifier: feedCell, for: indexPath) as! FeedTableViewCell
        let cellData = feeds[indexPath.row]
        cell.get(data: cellData)
        cell.postImgRes = cellData.postImgRes
        cell.postIdx = cellData.postIdx
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  (feedTableView.bounds.height) * 1.2
    }
     
}

extension FeedViewController: FeedCellDelegate {
    func imagePageChanged(pageControl: UIPageControl, postImgRes: [FeedPostImages], imageView: UIImageView) {
        let feedImgUrl = URL(string: postImgRes[pageControl.currentPage].postImgUrl)
        imageView.kf.setImage(with: feedImgUrl)
    }
    func commentLabelTapped(postIdx: Int) {
        let comment = UIStoryboard.init(name: "HomeStoryboard", bundle: nil)
        let commentViewController = comment.instantiateViewController(withIdentifier: "CommentViewController") as! CommentViewController
        commentViewController.postIdx = postIdx
        UserDefaults.standard.set(postIdx, forKey: "postIdx")
        self.navigationController?.pushViewController(commentViewController, animated: true)
        
    }
}
