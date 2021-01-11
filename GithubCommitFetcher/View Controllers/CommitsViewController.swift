//
//  CommitsViewController.swift
//  GithubCommitFetcher
//
//  Created by chrchg on 1/10/21.
//  Copyright © 2021 chrchg. All rights reserved.
//

import UIKit

class CommitsViewController: UIViewController {
    
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
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        print(commitMetadata[0].sha)
    }
}
