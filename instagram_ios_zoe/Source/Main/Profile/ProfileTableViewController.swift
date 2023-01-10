//
//  ProfileTableViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/09.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    lazy var dataManager: ProfileDataManager = ProfileDataManager()
    @IBOutlet weak var userIdBarButton: UIBarButtonItem!
    @IBOutlet weak var userIdButton: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("profile tableview will appear")
        dataManager.getProfileDataInTableView(delegate: self)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("profile tableview did appear")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("tableviewdidload")
        //dataManager.getProfileDataInTableView(delegate: self)
    }
    @IBAction func createPostButtonTouchUpInside(_ sender: UIButton) {
        let createModalViewController = self.storyboard?.instantiateViewController(identifier: "CreateModalViewController") as! CreateModalViewController
        self.present(createModalViewController, animated: true, completion: nil)
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
extension ProfileTableViewController {
    func didSetProfile(result: ProfileResult) {
        // 아이디
        userIdButton.setTitle(result.userId, for: .normal)
        userIdButton.titleLabel?.font = .Roboto(.bold, size: 25)

    }
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
