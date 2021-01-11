//
//  InputViewController.swift
//  GithubCommitFetcher
//
//  Created by chrchg on 1/10/21.
//  Copyright © 2021 chrchg. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {
    
    private let instructionLabel = UILabel()
    private let repoInputTextField = UITextField()
    private let ownerInputTextField = UITextField()
    private let submitButton = UIButton()
    private var commitMetadata = [CommitMetadata]()
    let rangerString = "ranger"
    let generalMotorsString = "generalmotors"
    let regularAttributedString = [NSAttributedString.Key.font : UIFont(name: "Helvetica", size: 17)]
    let boldAttributedString = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)]

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

    private func constructViews() {
        self.view.backgroundColor = .white
        self.constructInstructionLabel()
        self.constructTextField(textField: self.repoInputTextField, placeholder: "Repository name")
        self.constructTextField(textField: self.ownerInputTextField, placeholder: "Repository owner")
        self.constructSubmitButton()
    }
    
    private func constructInstructionLabel() {
        self.instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.instructionLabel.attributedText = self.constructAttributedString()
        self.instructionLabel.textColor = UIColor(displayP3Red: 0.29, green: 0.29, blue: 0.29, alpha: 1.0)
        self.instructionLabel.numberOfLines = 4
        self.view.addSubview(self.instructionLabel)
    }
    
    private func constructAttributedString() -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: "Enter a repository name and owner! \n\nNot sure? Try repository name" + " ", attributes: self.regularAttributedString as [NSAttributedString.Key : Any])
        let rangerAttributedString = NSMutableAttributedString(string: self.rangerString, attributes: self.boldAttributedString)
        let attributedStringMid = NSMutableAttributedString(string: " " + "and owner" + " ", attributes: self.regularAttributedString as [NSAttributedString.Key : Any])
        let generalMotorsAttributedString = NSMutableAttributedString(string: self.generalMotorsString, attributes: self.boldAttributedString)
        let attributedStringEnd = NSMutableAttributedString(string: ".", attributes: self.regularAttributedString as [NSAttributedString.Key : Any])
        attributedString.append(rangerAttributedString)
        attributedString.append(attributedStringMid)
        attributedString.append(generalMotorsAttributedString)
        attributedString.append(attributedStringEnd)
        return attributedString
    }
    
    private func constructTextField(textField: UITextField, placeholder: String) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 0.612, green: 0.612, blue: 0.612, alpha: 1.0)])
        textField.textColor = UIColor(displayP3Red: 0.29, green: 0.29, blue: 0.29, alpha: 1.0)
        textField.autocorrectionType = .no
        view.addSubview(textField)
    }
    
    private func constructSubmitButton() {
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
    
    private func layoutViews() {
        let views = [
            "instructionLabel": self.instructionLabel,
            "repoInputTextField": self.repoInputTextField,
            "ownerInputTextField": self.ownerInputTextField,
            "submitButton": self.submitButton
        ]
        var constraints = [NSLayoutConstraint]()
        
        // Vertical constraints
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[instructionLabel]-16-[repoInputTextField]-14-[ownerInputTextField]-14-[submitButton]",
            options: [],
            metrics: nil,
            views: views)
        constraints += [NSLayoutConstraint(item: self.submitButton,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .centerY,
            multiplier: 1,
            constant: 0)]
        
        // Horizontal constraints
        constraints += [NSLayoutConstraint(item: self.instructionLabel,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .centerX,
            multiplier: 1,
            constant: 0)]
        constraints += [NSLayoutConstraint(item: self.instructionLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: self.submitButton,
            attribute: .width,
            multiplier: 1,
            constant: 0)]
        constraints += [NSLayoutConstraint(item: self.repoInputTextField,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .centerX,
            multiplier: 1,
            constant: 0)]
        constraints += [NSLayoutConstraint(item: self.repoInputTextField,
            attribute: .width,
            relatedBy: .equal,
            toItem: self.submitButton,
            attribute: .width,
            multiplier: 1,
            constant: 0)]
        constraints += [NSLayoutConstraint(item: self.ownerInputTextField,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .centerX,
            multiplier: 1,
            constant: 0)]
        constraints += [NSLayoutConstraint(item: self.ownerInputTextField,
            attribute: .width,
            relatedBy: .equal,
            toItem: self.submitButton,
            attribute: .width,
            multiplier: 1,
            constant: 0)]
        constraints += [NSLayoutConstraint(item: self.submitButton,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .centerX,
            multiplier: 1,
            constant: 0)]
        constraints += [NSLayoutConstraint(item: self.submitButton,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .leading,
            multiplier: 1,
            constant: 50)]
        NSLayoutConstraint.activate(constraints)
    }
}
