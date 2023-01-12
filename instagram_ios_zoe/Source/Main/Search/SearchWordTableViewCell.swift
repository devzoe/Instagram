//
//  SearchWordTableViewCell.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/07.
//

import UIKit

protocol SearchWordDelegate {
    func deleteTapped(word : String)
}
class SearchWordTableViewCell: UITableViewCell {
    var delegate: SearchWordDelegate?
    @IBOutlet weak var searchWordLabel: UILabel!
    var searchWord = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func get(data: RecentSearchesResult){
        searchWordLabel.text = data.searchWord
        print(searchWordLabel.text )
    }
    
    @IBAction func deleteWordButtonTouchUpInside(_ sender: UIButton) {
        print("delete button tapped", sender)
        self.delegate?.deleteTapped(word: searchWord)
    }
    
}
