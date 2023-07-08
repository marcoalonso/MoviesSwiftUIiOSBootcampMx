//
//  NetwokManager.swift
//  Movies
//
//  Created by Marco Alonso Rodriguez on 01/07/23.
//

import Foundation

enum APError: Error {
    case invalidURL
    case invalidData
}

class NetworkManager {
    static let shared = NetworkManager()
    
    static let upcoming = "https://api.themoviedb.org/3/movie/upcoming?api_key=2cfa8720256036601fb9ac4e4bce1a9b&language=es-MX&page=1"
    
    static let nowPlaying = "https://api.themoviedb.org/3/movie/now_playing?api_key=2cfa8720256036601fb9ac4e4bce1a9b&language=es-MX&page=1"
    
    static let trending = "https://api.themoviedb.org/3/trending/all/day?api_key=2cfa8720256036601fb9ac4e4bce1a9b"
    
    init() {}
    
    func getUpcomingMovies(numPag: Int = 1, completed: @escaping (Result<[DataMovie], Error>) -> ()){
        guard let url = URL(string: NetworkManager.upcoming) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(MovieDataModel.self, from: data)
                completed(.success(decodedResponse.results))
            } catch {
                print("Debug: error \(error.localizedDescription)")
                completed(.failure(error))
            }
        }
        task.resume()
    }
    
    func getMoviesTrending(numPag: Int = 1, completed: @escaping (Result<[DataMovie], Error>) -> ()){
        guard let url = URL(string: NetworkManager.trending) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(MovieDataModel.self, from: data)
                completed(.success(decodedResponse.results))
            } catch {
                print("Debug: error \(error.localizedDescription)")
                completed(.failure(error))
            }
        }
        task.resume()
    }
    
    func getMoviesNowPlaying(numPag: Int = 1, completed: @escaping (Result<[DataMovie], Error>) -> ()){
        guard let url = URL(string: NetworkManager.nowPlaying) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(MovieDataModel.self, from: data)
                completed(.success(decodedResponse.results))
            } catch {
                print("Debug: error \(error.localizedDescription)")
                completed(.failure(error))
            }
        }
        task.resume()
    }
    
    func getListOfTrailers(id: Int, completed: @escaping (Result<[Trailer], APError>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=2cfa8720256036601fb9ac4e4bce1a9b&language=es_MX") else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(TrailerResponse.self, from: data)
                completed(.success(decodedResponse.results))
            } catch {
                print("Error al decodificar")
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func searchMovies(name: String, completed: @escaping (Result<[DataMovie], APError>) -> Void ) {
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=2cfa8720256036601fb9ac4e4bce1a9b&language=es-MX&page=1&include_adult=false&query=\(name)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(MovieDataModel.self, from: data)
                completed(.success(decodedResponse.results))
            } catch {
                print("Error al decodificar")
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}

