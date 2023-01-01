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
    
    var feeds : [Feed] = []
    
    @IBOutlet weak var feedTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFeedTableView()
        
        dataManager.getFeedList(delegate: self)
    }
    
    private func setupFeedTableView() {
        feedTableView.register(
            UINib(nibName: feedCell, bundle: nil),
            forCellReuseIdentifier: feedCell
        )
        feedTableView.delegate = self
        feedTableView.dataSource = self
    }

}
extension FeedViewController {
    func didSetFeed(result: FeedResponse) {
        feeds = result.feedList
        feedTableView.reloadData()
    }
    
    func failedToRequest(message: String) {
        //self.presentAlert(title: message)
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  (feedTableView.bounds.height) * 1
    }

}
