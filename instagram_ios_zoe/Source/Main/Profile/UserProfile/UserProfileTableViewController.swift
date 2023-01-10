//
//  UserProfileTableViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/11.
//

import UIKit

class UserProfileTableViewController: UITableViewController {
    var profileId = ""
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("profile tableview will appear")
        // 아이디
        self.navigationController?.title = profileId
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.Roboto(.medium, size: 17)
        ]
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("profile tableview did appear")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("tableviewdidload")
    }
    @IBAction func settingButtonTouchUpInside(_ sender: UIButton) {
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
}
