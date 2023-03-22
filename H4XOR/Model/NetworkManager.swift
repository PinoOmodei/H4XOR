//
//  NetworkManager.swift
//  H4XOR
//
//  Created by Pino Omodei on 22/03/23.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var posts = [Post]()  // posts: [Post] = []
    
    func fetchData() {
        // 1. Create URL
        if let url = URL(string: "https://hn.algolia.com/api/v1/search?tags=front_page") {
            // 2. Create session
            let session = URLSession(configuration: .default)
            // 3. assign a dataTask to the session, with that url --> JSON results arrive in (safe)data encoded
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    if let safeData = data {
                        do {
                            // 4. Decode from JSON to Swift object ([Post] is Results.hits)
                            let decoder = JSONDecoder()
                            let results = try decoder.decode(Results.self, from: safeData)
                            // 5. Consume the fetched data --> PUBLISHED
                            DispatchQueue.main.async {
                                self.posts = results.hits
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}

struct Results: Decodable {
    let hits: [Post]
}

struct Post: Decodable, Identifiable {
    var id: String {
        return objectID
    }
    let objectID: String
    let title: String
    let url: String?
    let points: Int
}
