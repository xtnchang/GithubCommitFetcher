//
//  CommitsViewController.swift
//  GithubCommitFetcher
//
//  Created by chrchg on 1/10/21.
//  Copyright © 2021 chrchg. All rights reserved.
//

import UIKit

class CommitsViewController: UITableViewController {
    
    private let commitMetadata: [CommitMetadata]
    
    init (data: [CommitMetadata]) {
        self.commitMetadata = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.constructViews()
        self.constructTableView()
    }
    
    private func constructViews() {
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = StringConstants.COMMITS
    }
    
    private func constructTableView() {
        self.setTableViewDelegates()
        self.tableView.register(CommitDataCell.self, forCellReuseIdentifier: CommitDataCell.cellReuseIdentifier)
        self.tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func setTableViewDelegates() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

// MARK: Table View Delegate Methods
extension CommitsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commitMetadata.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView,
                                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: CommitDataCell.cellReuseIdentifier, for: indexPath) as! CommitDataCell
        let rowIndex = indexPath.row
        let message = commitMetadata[rowIndex].commit.message
        let author = commitMetadata[rowIndex].commit.author.name
        let sha = commitMetadata[rowIndex].sha
        cell.setCellText(message: message, author: author, sha: sha)
        cell.selectionStyle = .none
        return cell
    }
}
