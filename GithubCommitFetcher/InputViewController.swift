//
//  InputViewController.swift
//  GithubCommitFetcher
//
//  Created by chrchg on 1/10/21.
//  Copyright © 2021 chrchg. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {
    
    private let submitButton = UIButton()
    private var commitMetadata = [CommitMetadata]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.constructViews()
        self.layoutViews()
        CommitFetcher.fetchCommits { result in
            self.commitMetadata = result
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func constructViews() {
        self.view.backgroundColor = .white
        self.constructSubmitButton()
    }
    
    func constructSubmitButton() {
        self.submitButton.translatesAutoresizingMaskIntoConstraints = false
        self.submitButton.setTitle("View Commits", for: .normal)
        self.submitButton.backgroundColor = UIColor(displayP3Red: 0, green: 0.659, blue: 0.902, alpha: 1.0)
        self.submitButton.layer.cornerRadius = 4.0
        self.submitButton.addTarget(self, action: #selector(self.validateInputs(_:)), for: .touchUpInside)
        self.view.addSubview(self.submitButton)
    }
    
    @objc func validateInputs(_ sender: AnyObject) {
        let commitsViewController = CommitsViewController(data: self.commitMetadata)
        self.navigationController?.pushViewController(commitsViewController, animated: true)
    }
    
    func layoutViews() {
        let views = [
            "submitButton": self.submitButton
        ]
        var constraints = [NSLayoutConstraint]()
        
        // Vertical constraints
        constraints += [NSLayoutConstraint(item: self.submitButton,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .centerY,
            multiplier: 1,
            constant: 0)]
        
        // Horizontal constraints
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:[submitButton(300)]",
            options: [],
            metrics: nil,
            views: views)
        constraints += [NSLayoutConstraint(item: self.submitButton,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .centerX,
            multiplier: 1,
            constant: 0)]
        NSLayoutConstraint.activate(constraints)
    }
}
