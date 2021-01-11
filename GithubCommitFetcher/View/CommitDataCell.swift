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
    let author = "Author"
    let sha = "a3e5ff02950c0ebc0f3f6b5ce18d5b5d3bd48afe"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.configureCellTitle()
        self.configureCellSubtitles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCellTitle() {
        self.textLabel?.text = "Commit message"
        self.textLabel?.numberOfLines = 2
        self.textLabel?.lineBreakMode = .byTruncatingTail
    }
    
    func configureCellSubtitles() {
        self.detailTextLabel?.text = "\(self.author) \n\(self.sha)"
        self.detailTextLabel?.numberOfLines = 2
        self.detailTextLabel?.lineBreakMode = .byTruncatingTail
    }
}
