//
//  ApiManager.swift
//  YassirMovieApplication
//
//  Created by MacBook AIR on 22/06/2024.
//

import Foundation
import Alamofire

struct Constants {
    static let Api_key = "30bbc9465ce5edc1448ae2367d7727b7"
    static let BaseURL = "https://api.themoviedb.org/3/"
    static let AuthorizationToken =  "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwZjgwMDI5MTMyYzJhYWFhNjVjNTU1ZDg4ZDk5Zjc0ZSIsIm5iZiI6MTcxOTA4NzA2My42NzAwMjksInN1YiI6IjY2NzcyZWQ0NTJlOGQ1MDk5MTVlNzBiMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GqDlNVeG1TpJRdDNx6jDIlDwo0uHOi05_fUdJ5nEvHU"
}


class ApiManager {
    
  static let shared = ApiManager()
    
    
    public func getTrendingMovies(completion: @escaping (Result<[RecommendedUser], Error>) -> Void) {
        guard let url = URL(string:"\(Constants.BaseURL)discover/movie") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constants.AuthorizationToken)"
        ]

        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode([RecommendedUser].self, from: data)
                        completion(.success(result))
                    } catch let decodingError {
                        completion(.failure(decodingError))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }

    
    
    
    
}
