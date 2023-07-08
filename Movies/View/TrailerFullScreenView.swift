//
//  TrailerFullScreenView.swift
//  Movies
//
//  Created by Marco Alonso Rodriguez on 08/07/23.
//

import SwiftUI
import YouTubeiOSPlayerHelper

struct TrailerFullScreenView: View {
    
    @Binding var urlTrailer: String
    
    var body: some View {
        YTWrapper(videoID: urlTrailer)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct TrailerFullScreenView_Previews: PreviewProvider {
    static var previews: some View {
        TrailerFullScreenView(urlTrailer: .constant(MockData.idTrailer))
    }
}
