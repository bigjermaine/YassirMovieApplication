//
//  ApiManager.swift
//  YassirMovieApplication
//
//  Created by MacBook AIR on 22/06/2024.
//

import Foundation
import Alamofire


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
                            completion(.failure(NetworkError.decodingFailed))
                        }
                    case .failure(let error):
                        if let underlyingError = error.underlyingError as NSError?,
                           underlyingError.domain == NSURLErrorDomain,
                           underlyingError.code == NSURLErrorNotConnectedToInternet {
                            completion(.failure(NetworkError.noInternetConnection))
                        } else {
                            completion(.failure(error))
                        }
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
