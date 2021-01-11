//
//  CommitFetcherModel.swift
//  GithubCommitFetcher
//
//  Created by chrchg on 1/10/21.
//  Copyright © 2021 chrchg. All rights reserved.
//

import Foundation

struct Response: Codable {
    let sha: String
    let commit: Commit
}

struct Commit: Codable {
    let author: Author
    let message: String
}

struct Author: Codable {
    let name: String
    let email: String
    let date: String
}
