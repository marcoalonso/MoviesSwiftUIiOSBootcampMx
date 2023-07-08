//
//  SearchMoviesViewModel.swift
//  Movies
//
//  Created by Marco Alonso Rodriguez on 08/07/23.
//

import Foundation

class SearchMoviesViewModel: ObservableObject {
    @Published var moviesFounded: [DataMovie] = []
    
    func searchMovie(name: String) {
        NetworkManager.shared.searchMovies(name: name) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.moviesFounded = movies
                    
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
            }
        }
    }
}
