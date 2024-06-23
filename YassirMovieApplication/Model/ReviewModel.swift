//
//  ReviewModel.swift
//  YassirMovieApplication
//
//  Created by MacBook AIR on 23/06/2024.
//

import Foundation
struct MovieReviewsResponse: Codable {
    let id: Int
    let page: Int
    let results: [MovieReview]
    let total_pages: Int
    let total_results: Int
}

struct MovieReview: Codable {
    let author: String
    let author_details: AuthorDetails
    let content: String
    let created_at: String
    let id: String
    let updated_at: String
    let url: String
}

struct AuthorDetails: Codable {
    let name: String?
    let username: String
    let avatar_path: String?
    let rating: Int?
}
