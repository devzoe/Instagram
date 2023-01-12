//
//  SearchAccountViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/07.
//

import UIKit

class SearchAccountViewController: UIViewController {
    lazy var dataManager : SearchingDataManager = SearchingDataManager()
    let cellId = "SearchingTableViewCell"
    var searchRequest : SearchRequest = SearchRequest(word: "")
    var accounts : [SearchResult] = []
    @IBOutlet weak var accountTableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpSearchTableView()
        dataManager.getAccountData(searchRequest, delegate: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setUpSearchTableView() {
        accountTableView.delegate = self
        accountTableView.dataSource = self
        accountTableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
}
extension SearchAccountViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SearchingTableViewCell
        let cellData = accounts[indexPath.row]
        cell.get(data: cellData)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  (accountTableView.bounds.height) * 0.15
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let profileView = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController
        //self.navigationController?.pushViewController(profileView, animated: true)
    }
}

extension SearchAccountViewController {
    func didSuccessSearch(result: [SearchResult]) {
        accounts = result
        accountTableView.reloadData()
    }
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
