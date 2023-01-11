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
    lazy var randomPostDataManager = RecommendPostDataManager()
    var recentSearchesResult : [RecentSearchesResult] = []
    let cellId = "SearchWordTableViewCell"
    var randomPosts : [RecommendPostResult] = []
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var recommendPostCollectionView: UICollectionView!
    let cellMarginSize: CGFloat = 1
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchTableView.isHidden = true
        recommendPostCollectionView.isHidden = false
        setUpUI()
        setUpCollectionView()
        self.randomPostDataManager.getRandomPost(delegate: self)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        recentSearchesResult = []
        searchTableView.reloadData()
        searchTableView.isHidden = true
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
    func setUpCollectionView() {
        self.recommendPostCollectionView.dataSource = self
        self.recommendPostCollectionView.delegate = self
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchRequest = SearchRequest(word: recentSearchesResult[indexPath.row].searchWord)
        let searchView = self.storyboard?.instantiateViewController(withIdentifier: "SearchingTabViewController") as! SearchingTabViewController
        searchView.searchRequest = searchRequest
        self.navigationController?.pushViewController(searchView, animated: true)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    
    // 사용자가 검색창에 텍스트를 입력하면 실행되는 함수 (사용자가 검색하고자 하는 이름을 받아온다)
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
}

// 서치바
extension SearchViewController: UISearchBarDelegate {
    // 서치바에서 검색을 시작할 때 호출
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("검색 시작")
        recommendPostCollectionView.isHidden = true
        searchTableView.isHidden = false
        configure()
        datamanager.getRecentSearchesData(delegate: self)
    }
    
    // 서치바에서 검색버튼을 눌렀을 때 호출
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }
    
    // 서치바에서 취소 버튼을 눌렀을 때 호출
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        recentSearchesResult = []
        searchTableView.reloadData()
        recommendPostCollectionView.isHidden = false
        searchTableView.isHidden = true
    }
    
    // 서치바 검색이 끝났을 때 호출
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        recentSearchesResult = []
        recentSearchesResult.append(RecentSearchesResult(searchWord: searchBar.text!, status: ""))
        print(recentSearchesResult)
        self.searchTableView.reloadData()
    }
    
    // 서치바 키보드 내리기
    override func dismissKeyboard() {
        searchController.searchBar.resignFirstResponder()
    }
}

// api
extension SearchViewController {
    func didSuccessRecentSearches(result: RecentSearchesResponse) {
        print("검색 결과 불러오기")
        print(result)
        recentSearchesResult = result.result!
        print(recentSearchesResult)
        self.searchTableView.reloadData()
    }
    func didGetRandomPost(result: [RecommendPostResult]) {
        self.randomPosts = result
        self.recommendPostCollectionView.reloadData()
    }
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}

// collection view
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return randomPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendPostCollectionViewCell", for: indexPath) as! RecommendPostCollectionViewCell
        let cellData = randomPosts[indexPath.row]
        cell.get(data: cellData)
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    // 셀 크기 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let numberOfItemsPerRow: CGFloat = 3
        let spacing: CGFloat = self.cellMarginSize
        let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
        let itemDimension = floor(availableWidth / numberOfItemsPerRow)

        return CGSize(width: itemDimension, height: itemDimension)
    }
    // 섹션에서 콘텐츠를 배치하는 데 사용되는 여백
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    
    // 그리드의 항목 줄 사이에 사용할 최소 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.cellMarginSize
    }

    // 같은 행에 있는 항목 사이에 사용할 최소 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.cellMarginSize
    }
    
}

