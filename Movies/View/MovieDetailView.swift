//
//  MovieDetailView.swift
//  Movies
//
//  Created by Marco Alonso Rodriguez on 01/07/23.
//

import SwiftUI
import Kingfisher
import YouTubeiOSPlayerHelper

struct MovieDetailView: View {
    @StateObject var viewModel = TrailerViewModel()
    @State var showTrailer = false
    @State var urlTrailerSelected: String = ""
    
    let movie: DataMovie //recibir la movie seleccionada
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10.0) {
                
                if !viewModel.listOfTrailers.isEmpty {
                    YTWrapper(videoID: viewModel.listOfTrailers[0].key)
                        .frame(height: 200)
                        .cornerRadius(12)
                }
                
                Text(movie.overview ?? "")
                    .font(.body)
                
                
                
                HStack {
                    Text(movie.release_date ?? "")
                        .font(.callout)
                        .bold()
                    
                    Text("\(String(format: "%.1f", movie.vote_average ?? 0)) ⭐️")
                        .font(.callout)
                        .bold()
                }
                
                Text("Trailers")
                    .font(.title)
                
                List(viewModel.listOfTrailers, id: \.key) { trailer in
                    HStack {
                        KFImage(URL(string: "\(Constants.urlImages)\(movie.backdrop_path ?? "")"))
                            .resizable()
                            .placeholder { _ in
                                ProgressView()
                            }
                            .frame(width: 120, height: 80)
                            .cornerRadius(12)
                        
                        VStack(spacing: 5.0) {
                            Text(trailer.name)
                                .font(.body)
                            
                            Text(trailer.published_at)
                                .font(.footnote)
                                .foregroundColor(.red)
                            
                            Text("Type: \(trailer.type)")
                                .font(.caption2)
                                .bold()
                            
                        }
                    }//Hstack
                    .onTapGesture {
                        self.urlTrailerSelected = trailer.key
                        showTrailer = true
                    }
                }
                .listStyle(.inset)
                .frame(height: 300)
                
                KFImage(URL(string: "\(Constants.urlImages)\(movie.poster_path ?? "")"))
                    .resizable()
                    .placeholder { _ in
                        ProgressView()
                    }
                    .frame(maxHeight: 350)
                    .cornerRadius(12)
                
                    .navigationTitle(movie.original_title ?? movie.title ?? "")
                    .navigationBarItems(trailing: Button(action: {
                        print("Compartir")
                    }, label: {
                        Image(systemName: "square.and.arrow.up.fill")
                    }))
            }//Vstack
            .sheet(isPresented: $showTrailer, content: {
                TrailerFullScreenView(urlTrailer: $urlTrailerSelected)
            })
            .onAppear {
                viewModel.getTrailers(id: movie.id)
            }
            .padding(.trailing, 20)
            .padding(.leading, 20)
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: MockData.movie)
    }
}

struct YTWrapper : UIViewRepresentable {
    var videoID : String
    
    func makeUIView(context: Context) -> YTPlayerView {
        let playerView = YTPlayerView()
        playerView.load(withVideoId: videoID)
        return playerView
    }
    
    func updateUIView(_ uiView: YTPlayerView, context: Context) {
    }
}
