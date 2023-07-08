//
//  MovieCellView.swift
//  Movies
//
//  Created by Marco Alonso Rodriguez on 01/07/23.
//

import SwiftUI
import Kingfisher

struct MovieCellView: View {
    
    let movie: DataMovie
    
    var body: some View {
        VStack {
            KFImage(URL(string: "\(Constants.urlImages)\(movie.poster_path ?? "")"))
                .resizable()
                .placeholder { _ in
                    ProgressView()
                }
                .cornerRadius(12)
        }
    }
}

struct MovieCellView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCellView(movie: MockData.movie)
    }
}
