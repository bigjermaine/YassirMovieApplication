//
//  BookMarkManager.swift
//  YassirMovieApplication
//
//  Created by MacBook AIR on 23/06/2024.
//

import Foundation

//
//extension  UserDefaults  {
//
//    static let dowloadEpisodeKey = "dowloadEpisodeKey"
//    
//     func downloadMovie(episode:PodcastEpisode) {
//        
//        do {
//            var dowloadEpisodes =  dowloadedEpisodes()
//            dowloadEpisodes.append(episode)
//            let data = try JSONEncoder().encode(dowloadEpisodes)
//            UserDefaults.standard.set(data, forKey: UserDefaults.dowloadEpisodeKey)
//        }catch let error {
//            print(error.localizedDescription)
//        }
//    }
//    
//     func dowloadedMovies() -> [PodcastEpisode]  {
//        guard let episodeData = data(forKey: UserDefaults.dowloadEpisodeKey) else {return []}
//        do {
//            let data =  try JSONDecoder().decode([PodcastEpisode].self, from: episodeData)
//            return data
//        }catch let error {
//            print(error)
//        }
//        return []
//    }
//   
//    func deleteMovie(at index: Int) {
//        var downloadEpisodes =  dowloadedEpisodes()
//        guard index >= 0, index < downloadEpisodes.count else {
//            return
//        }
//        downloadEpisodes.remove(at: index)
//        do {
//            let data = try JSONEncoder().encode(downloadEpisodes)
//            set(data, forKey: UserDefaults.dowloadEpisodeKey)
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
//}
//
//
