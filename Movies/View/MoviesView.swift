//
//  ContentView.swift
//  Movies
//
//  Created by Marco Alonso Rodriguez on 01/07/23.
//

import SwiftUI

struct MoviesView: View {
    
    @StateObject private var viewModel = MoviesViewModel()
    
    var gridItemLayout = [GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Proximos estrenos")
                        .font(.largeTitle)
                    
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: gridItemLayout, spacing: 20) {
                            ForEach(viewModel.upcomingMovies, id: \.id) { movie in
                                
                                NavigationLink {
                                    MovieDetailView(movie: movie)
                                } label: {
                                    MovieCellView(movie: movie)
                                        .frame(width: 200, height: 300)
                                }

                            
                            }
                        }//LazyHGrid
                    }///Scroll Horizontal
                    
                    Text("Ahora en cines")
                        .font(.largeTitle)
                    
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: gridItemLayout, spacing: 20) {
                            ForEach(viewModel.nowplayingMovies, id: \.id) { movie in
                                
                                NavigationLink {
                                    MovieDetailView(movie: movie)
                                } label: {
                                    MovieCellView(movie: movie)
                                        .frame(width: 150, height: 200)
                                }

                            
                            }
                        }//LazyHGrid
                    }///Scroll Horizontal
                    
                    Text("Tendencia")
                        .font(.largeTitle)
                    
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: gridItemLayout, spacing: 20) {
                            ForEach(viewModel.trendingMovies, id: \.id) { movie in
                                
                                NavigationLink {
                                    MovieDetailView(movie: movie)
                                } label: {
                                    MovieCellView(movie: movie)
                                        .frame(width: 300, height: 400)
                                }

                            
                            }
                        }//LazyHGrid
                    }///Scroll Horizontal
                    
                }///Vstack
                .padding(15)
            }///Scroll
            .navigationBarTitle("Movies", displayMode: .inline)
            .navigationBarItems(trailing: NavigationLink(destination: SearchMoviesView(), label: {
                Image(systemName: "magnifyingglass")
            }))
        }///NavigationView
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}


