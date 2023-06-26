//
//  MovieSearchViewModel.swift
//  Movies
//
//  Created by yves on 26/06/2023.
//

import Foundation

class MovieSearchViewModel: ObservableObject {
    
    @Published var listOfMovies:[Movie] = []
    
    func fetchMovies() async {
        let apikey = "keyro44SJvXTIfPNs"
        if let url = URL(string: "https://api.airtable.com/v0/appTT0t4FupHVTbOf/tbl2qpwiUFVeocVFW/") {
            do {
                var request = URLRequest(url: url)
                request.setValue("Bearer \(apikey)",forHTTPHeaderField: "Authorization")
                let (data, _) = try await URLSession.shared.data(for: request)
                if let decodedResponse = try?
                    JSONDecoder().decode(MovieResponse.self, from: data){
                    
                    listOfMovies = decodedResponse.movies
                    }
            } catch {
                print("Invalid data")
            }
        }
    }
    
}
