//
//  ApiModels.swift
//  Movies
//
//  Created by yves on 26/06/2023.
//

import Foundation

struct MovieResponse: Codable {
    let records: [Record]
    
    var movies: [Movie] {
        return records.map { rec in
            var movie = rec.fields
            movie.id = rec.id ?? "EF12030JF320"
                    return movie
                //}
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case records
    }
}

struct Record: Codable, Identifiable {
    var id: String?
    var fields: Movie
}
