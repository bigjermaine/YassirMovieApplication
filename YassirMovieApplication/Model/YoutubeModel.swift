//
//  YoutubeModel.swift
//  YassirMovieApplication
//
//  Created by MacBook AIR on 23/06/2024.
//

import Foundation

struct Videoelement: Codable {
    let id:Idvideoelement
}


struct Idvideoelement:Codable {
    let kind:String
    let videoId: String
}

struct Youtubesearchresults: Codable {
    
    let items: [Videoelement]
}
