//
//  TrailerViewModel.swift
//  Movies
//
//  Created by Marco Alonso Rodriguez on 08/07/23.
//

import Foundation

class TrailerViewModel: ObservableObject {
    @Published var listOfTrailers: [Trailer] = []
    
    func getTrailers(id: Int){
        NetworkManager.shared.getListOfTrailers(id: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let trailers):
                    self.listOfTrailers = trailers
                    
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
