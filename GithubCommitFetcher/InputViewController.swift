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
    let regularAttributedString = [NSAttributedString.Key.font : UIFont(name: "Helvetica", size: 17)]
    let boldAttributedString = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.constructViews()
        self.layoutViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.clearTextFields()
    }

    private func constructViews() {
        self.view.backgroundColor = .white
        self.constructInstructionLabel()
        self.constructTextField(textField: self.ownerInputTextField, placeholder: StringConstants.REPOSITORY_OWNER)
        self.constructTextField(textField: self.repoInputTextField, placeholder: StringConstants.REPOSITORY_NAME)
        self.constructSubmitButton()
    }
    
    private func constructInstructionLabel() {
        self.instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.instructionLabel.attributedText = self.constructAttributedString()
        self.instructionLabel.textColor = ColorConstants.DARK_GRAY
        self.instructionLabel.numberOfLines = 6
        self.view.addSubview(self.instructionLabel)
    }
    
    private func constructTextField(textField: UITextField, placeholder: String) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: ColorConstants.LIGHT_GRAY])
        textField.textColor = ColorConstants.DARK_GRAY
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        view.addSubview(textField)
    }
    
    private func clearTextFields() {
        self.repoInputTextField.text = ""
        self.ownerInputTextField.text = ""
    }
    
    private func constructSubmitButton() {
        self.submitButton.translatesAutoresizingMaskIntoConstraints = false
        self.submitButton.setTitle(StringConstants.VIEW_COMMITS, for: .normal)
        self.submitButton.backgroundColor = ColorConstants.BRIGHT_BLUE
        self.submitButton.layer.cornerRadius = 4.0
        self.submitButton.addTarget(self, action: #selector(self.validateInputs(_:)), for: .touchUpInside)
        self.view.addSubview(self.submitButton)
    }
    
    @objc func validateInputs(_ sender: AnyObject) {
        guard let repoName = self.repoInputTextField.text else {
            print("Empty input")
            return
        }
        guard let owner = self.ownerInputTextField.text else {
            print("Empty input")
            return
        }
        self.fetchCommitData(repoName: repoName, owner: owner)
    }
    
    private func showAlertView() {
        let alertViewController = UIAlertController(title: StringConstants.ERROR, message: StringConstants.ERROR_PLEASE_ENTER_VALID, preferredStyle: .alert)
        let okAction = UIAlertAction(title: StringConstants.OKAY, style: UIAlertAction.Style.default)
        alertViewController.addAction(okAction)
        self.present(alertViewController, animated: true, completion: nil)
    }
}

// MARK: View Formatting
extension InputViewController {
    private func layoutViews() {
        let views = [
            "instructionLabel": self.instructionLabel,
            "ownerInputTextField": self.ownerInputTextField,
            "repoInputTextField": self.repoInputTextField,
            "submitButton": self.submitButton
        ]
        var constraints = [NSLayoutConstraint]()
        
        // Vertical constraints
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[instructionLabel]-16-[ownerInputTextField]-14-[repoInputTextField]-14-[submitButton]",
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

// MARK: Network Request
extension InputViewController {
    private func fetchCommitData(repoName: String, owner: String) {
        CommitFetcher.fetchCommits(repoName: repoName, owner: owner, completionHandler: { didSucceed, result in
            if didSucceed {
                guard let result = result else {
                    return
                }
                self.commitMetadata = result
                DispatchQueue.main.async {
                    let commitsViewController = CommitsViewController(data: self.commitMetadata)
                    self.navigationController?.pushViewController(commitsViewController, animated: true)
                }
            } else {
                DispatchQueue.main.async {
                    self.showAlertView()
                }
            }
        })
    }
}

// MARK: Attributed String Helper Method
extension InputViewController {
    private func constructAttributedString() -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: StringConstants.INPUT_INSTRUCTION_BEGINNING, attributes: self.regularAttributedString as [NSAttributedString.Key : Any])
        let rangerAttributedString = NSMutableAttributedString(string: StringConstants.RANGER, attributes: self.boldAttributedString)
        let attributedStringMid = NSMutableAttributedString(string: StringConstants.INPUT_INSTRUCTION_MIDDLE, attributes: self.regularAttributedString as [NSAttributedString.Key : Any])
        let generalMotorsAttributedString = NSMutableAttributedString(string: StringConstants.GENERAL_MOTORS, attributes: self.boldAttributedString)
        let attributedStringEnd = NSMutableAttributedString(string: ".", attributes: self.regularAttributedString as [NSAttributedString.Key : Any])
        attributedString.append(generalMotorsAttributedString)
        attributedString.append(attributedStringMid)
        attributedString.append(rangerAttributedString)
        attributedString.append(attributedStringEnd)
        return attributedString
    }
}
