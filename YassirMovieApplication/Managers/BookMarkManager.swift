//
//  BookMarkManager.swift
//  YassirMovieApplication
//
//  Created by MacBook AIR on 23/06/2024.
//

import Foundation


extension  UserDefaults  {

    static let dowloadedMoviesKey = "dowloadEpisodeKey"
    
     func downloadMovie(episode:Movie) {
        
        do {
            var dowloadEpisodes =  dowloadedMovies()
            dowloadEpisodes.append(episode)
            let data = try JSONEncoder().encode(dowloadEpisodes)
            UserDefaults.standard.set(data, forKey: UserDefaults.dowloadedMoviesKey)
        }catch let error {
            print(error.localizedDescription)
        }
    }
    
     func dowloadedMovies() -> [Movie]  {
        guard let episodeData = data(forKey: UserDefaults.dowloadedMoviesKey) else {return []}
        do {
            let data =  try JSONDecoder().decode([Movie].self, from: episodeData)
            return data
        }catch let error {
            print(error)
        }
        return []
    }
   
    func deleteMovie(at index: Int) {
        var dowloadedMovies =  dowloadedMovies()
        guard index >= 0, index < dowloadedMovies.count else {
            return
        }
        dowloadedMovies.remove(at: index)
        do {
            let data = try JSONEncoder().encode(dowloadedMovies)
            set(data, forKey: UserDefaults.dowloadedMoviesKey)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}


