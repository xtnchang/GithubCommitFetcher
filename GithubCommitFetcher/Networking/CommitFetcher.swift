//
//  CommitFetcher.swift
//  GithubCommitFetcher
//
//  Created by chrchg on 1/10/21.
//  Copyright © 2021 chrchg. All rights reserved.
//

import Foundation

class CommitFetcher: NSObject {
    
    class func fetchCommits(repoName: String, owner: String, completionHandler: @escaping (Bool, [CommitMetadata]?) -> ()) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.github.com"
        urlComponents.path = "/repos/\(owner)/\(repoName)/commits"
        guard let url = urlComponents.url else {
            print("No url found")
            return
        }
        var request = URLRequest(url: url.absoluteURL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completionHandler(false, nil)
                return
            }
            
            var responses: [CommitMetadata]?
            do {
                responses = try JSONDecoder().decode([CommitMetadata].self, from: data)
            } catch {
                completionHandler(false, nil)
            }
            guard let result = responses else {
                return
            }
            completionHandler(true, result)
        }
        task.resume()
    }
}
