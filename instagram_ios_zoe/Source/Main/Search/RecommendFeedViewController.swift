//
//  RecommendFeedViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/12.
//

import UIKit

class RecommendFeedViewController: UIViewController {
    let cellId = "RecommendPostTableViewCell"
    var feedResult : [RecommendFeedResult] = []
    @IBOutlet weak var recommendFeedTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    func setUpTableView() {
        self.recommendFeedTableView.delegate = self
        self.recommendFeedTableView.dataSource = self
        self.recommendFeedTableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
}

extension RecommendFeedViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RecommendPostTableViewCell
        let cellData = feedResult[indexPath.row]
        cell.get(data: cellData)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  (recommendFeedTableView.bounds.height) * 0.8
    }

}
