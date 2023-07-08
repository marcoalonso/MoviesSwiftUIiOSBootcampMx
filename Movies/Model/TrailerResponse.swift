//
//  TrailerResponse.swift
//  Movies
//
//  Created by Marco Alonso Rodriguez on 08/07/23.
//

import Foundation

struct TrailerResponse: Codable {
    let id: Int
    let results: [Trailer]
}

struct Trailer: Codable {
    let name: String
    let key: String
    let type: String
    let published_at: String
}
