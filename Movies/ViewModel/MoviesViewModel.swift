//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Marco Alonso Rodriguez on 01/07/23.
//

import Foundation


class MoviesViewModel: ObservableObject {
    @Published var upcomingMovies: [DataMovie] = []
    @Published var nowplayingMovies: [DataMovie] = []
    @Published var trendingMovies: [DataMovie] = []
    
    @Published var errorMessage: String = ""
    
    init() {
        getListOfUpcomingMovies()
        getMoviesNowPlaying()
        getMoviesTrending()
    }
    
    
    func getListOfUpcomingMovies() {
        NetworkManager.shared.getUpcomingMovies { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.upcomingMovies = movies
                    
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    
                }
            }
        }
    }
    
    func getMoviesNowPlaying() {
        NetworkManager.shared.getMoviesNowPlaying { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.nowplayingMovies = movies
                    
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    
                }
            }
        }
    }

    
    func getMoviesTrending() {
        NetworkManager.shared.getMoviesTrending { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.trendingMovies = movies
                    
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    
                }
            }
        }
    }

}
