//
//  CommitDataCell.swift
//  GithubCommitFetcher
//
//  Created by chrchg on 1/10/21.
//  Copyright © 2021 chrchg. All rights reserved.
//

import Foundation
import UIKit

class CommitDataCell: UITableViewCell {
    
    static let cellReuseIdentifier = "CommitDataCell"
    var message = String()
    var author = String()
    var sha = String()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCellText(message: String, author: String, sha: String) {
        self.message = message
        self.author = author
        self.sha = sha
        self.configureCellTitle()
        self.configureCellSubtitles()
    }

    private func configureCellTitle() {
        self.textLabel?.text = self.message
        self.textLabel?.numberOfLines = 2
    }
    
    private func configureCellSubtitles() {
        self.detailTextLabel?.text = "\(self.author) \n\(self.sha)"
        self.detailTextLabel?.textColor = UIColor(displayP3Red: 0.29, green: 0.29, blue: 0.29, alpha: 1.0)
        self.detailTextLabel?.numberOfLines = 2
        self.detailTextLabel?.lineBreakMode = .byTruncatingTail
    }
}
