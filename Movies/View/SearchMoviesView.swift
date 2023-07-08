//
//  SearchMoviesView.swift
//  Movies
//
//  Created by Marco Alonso Rodriguez on 08/07/23.
//

import SwiftUI

struct SearchMoviesView: View {
    @StateObject var viewModel = SearchMoviesViewModel()
    @State var nameOfMovie = ""
    
    let fixedColumns = [
        GridItem(.fixed(150)),
        GridItem(.fixed(150)),
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: fixedColumns) {
                    ForEach(viewModel.moviesFounded, id: \.id) { movie in
                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                            MovieCellView(movie: movie)
                                .frame(width: 150, height: 200)
                        }
                    }
                }
            }
        }
        .searchable(text: $nameOfMovie, prompt: "Buscar peliculas")
        .onChange(of: nameOfMovie) { newValue in
            viewModel.searchMovie(name: newValue)
        }
    }
}

struct SearchMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        SearchMoviesView()
    }
}
