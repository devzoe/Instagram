//
//  CommentHeaderView.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/10.
//

import UIKit
import SnapKit

class CommentHeaderView: UITableViewHeaderFooterView {
    static let headerViewID = "CommentHeaderView"
    
    var postProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var userIdLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .systemFont(ofSize: 11, weight: .medium)
        return label
    }()
    var updateAtLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .systemFont(ofSize: 10)
        label.textColor = .labelGray
        return label
    }()
    var contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupHeaderView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupHeaderView() {
        contentView.addSubview(postProfileImageView)
        contentView.addSubview(userIdLabel)
        contentView.addSubview(updateAtLabel)
        contentView.addSubview(contentLabel)
    }
    
    private func configureLayout() {
        DispatchQueue.main.async {
            self.postProfileImageView.layer.cornerRadius = self.postProfileImageView.frame.width / 2
            self.postProfileImageView.clipsToBounds = true
        }
        postProfileImageView.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(15)
            make.width.equalToSuperview().multipliedBy(0.08)
            make.height.equalTo(postProfileImageView.snp.width)
        })
        userIdLabel.snp.makeConstraints { make in
            make.leading.equalTo(postProfileImageView.snp.trailing).offset(10)
            make.top.equalTo(postProfileImageView.snp.top)
        }
        updateAtLabel.snp.makeConstraints { make in
            make.leading.equalTo(userIdLabel.snp.trailing).offset(5)
            make.top.equalTo(userIdLabel.snp.top)
        }
        contentLabel.snp.makeConstraints { make in
            make.leading.equalTo(userIdLabel.snp.leading)
            make.top.equalTo(userIdLabel.snp.bottom).offset(5)
        }
        
        
    }
    
    
}
