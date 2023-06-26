//
//  MovieModel.swift
//  Movies
//
//  Created by yves on 26/06/2023.
//

import Foundation

struct Movie: Identifiable, Codable {
    var id: String
    var title: String
    var year: String
    var moviemaker: String
    var actors: [String]
    
    
}
