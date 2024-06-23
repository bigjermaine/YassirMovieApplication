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
    static let imageBaseUrl = "https://image.tmdb.org/t/p/w500/"
    static let AuthorizationToken =  "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwZjgwMDI5MTMyYzJhYWFhNjVjNTU1ZDg4ZDk5Zjc0ZSIsIm5iZiI6MTcxOTA4NzA2My42NzAwMjksInN1YiI6IjY2NzcyZWQ0NTJlOGQ1MDk5MTVlNzBiMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GqDlNVeG1TpJRdDNx6jDIlDwo0uHOi05_fUdJ5nEvHU"
}


class ApiManager {
    
  static let shared = ApiManager()
    
    
    public func getDiscoverMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
         createRequest(with: "discover/movie", page: "1", type: .get) { request in
            AF.request(request)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let result = try JSONDecoder().decode(DiscoverMovieResponse.self, from: data)
                            print(result)
                            completion(.success(result.results))
                        } catch let decodingError {
                            completion(.failure(decodingError))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
        
    }
    
    func createRequest(with url:String,page:String, type:HTTPMethod, completion: @escaping(URLRequest)-> Void) {
        guard var components = URLComponents(string: "\(Constants.BaseURL)\(url)") else {return}
            let queryItems: [URLQueryItem] = [
                URLQueryItem(name: "page", value: "\(page)")
            ]
            components.queryItems = (components.queryItems ?? []) + queryItems
            guard let url = components.url else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.timeoutInterval = 10
            request.allHTTPHeaderFields = [
                "accept": "application/json",
                "Authorization": "Bearer \(Constants.AuthorizationToken)"
            ]
          completion(request)
    }
}
