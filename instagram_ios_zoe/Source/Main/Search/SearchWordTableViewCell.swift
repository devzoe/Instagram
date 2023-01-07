//
//  SearchWordTableViewCell.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/07.
//

import UIKit

class SearchWordTableViewCell: UITableViewCell {
    @IBOutlet weak var searchWordLabel: UILabel!
    
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
}
