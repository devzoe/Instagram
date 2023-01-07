//
//  SearchViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/07.
//

import UIKit

class SearchViewController: BaseViewController {
    let searchController = UISearchController(searchResultsController: nil)
    lazy var datamanager : RecentSearchesDataManager = RecentSearchesDataManager()
    var recentSearchesResult : [RecentSearchesResult] = []
    let cellId = "SearchWordTableViewCell"
    
    @IBOutlet weak var searchTableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUI()
        configure()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func setUpUI() {
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "검색"
        self.navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        // navigation item 스크롤 될때 사라지지 않게
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    private func configure() {
        self.searchTableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        self.searchTableView.dataSource = self
        self.searchTableView.delegate = self
    }

}
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count : ", recentSearchesResult.count)
        return recentSearchesResult.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("table view cell")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SearchWordTableViewCell else {
            print("tableview cell 등록 실패")
            return UITableViewCell() }
        let cellData = recentSearchesResult[indexPath.row]
        cell.get(data : cellData)
        print("cell : ", cellData)
        return cell
    }
}

extension SearchViewController: UISearchResultsUpdating {
    
    // 사용자가 검색창에 텍스트를 입력하면 실행되는 함수 (사용자가 검색하고자 하는 이름을 받아온다)
    func updateSearchResults(for searchController: UISearchController) {
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    // 서치바에서 검색을 시작할 때 호출
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("검색 시작")
        datamanager.getRecentSearchesData(delegate: self)
    }
    
    // 서치바에서 검색버튼을 눌렀을 때 호출
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }
    
    // 서치바에서 취소 버튼을 눌렀을 때 호출
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    }
    
    // 서치바 검색이 끝났을 때 호출
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    }
    
    // 서치바 키보드 내리기
    override func dismissKeyboard() {
        searchController.searchBar.resignFirstResponder()
    }
}

extension SearchViewController {
    func didSuccessRecentSearches(result: RecentSearchesResponse) {
        print("검색 결과 불러오기")
        print(result)
        recentSearchesResult = result.result!
        print(recentSearchesResult)
        self.searchTableView.reloadData()
    }
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
