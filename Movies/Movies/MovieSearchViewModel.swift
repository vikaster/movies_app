//
//  MovieSearchViewModel.swift
//  Movies
//
//  Created by yves on 26/06/2023.
//

import Foundation

class MovieSearchViewModel: ObservableObject {
    
    @Published var movieDetails:[AirTableSecondFloor]? = []
    
    func fetchMovies() async {
        let apikey = ""
        let urlOfAirtableMovie = "https://api.airtable.com/v0/appTT0t4FupHVTbOf/tbl2qpwiUFVeocVFW"
        var request = URLRequest(url: URL(string:urlOfAirtableMovie)!)
        request.setValue("Bearer \(apikey)", forHTTPHeaderField:"Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                do {
                    // Enregistre AirtableSearchResult dans les données capturées dans self.movieDetails
                    let AirtableSearchResult = try decoder.decode(MovieResponse.self, from: data)
                    print(type(of: AirtableSearchResult))
                    print(AirtableSearchResult)
                    self.movieDetails = AirtableSearchResult.records
                    
                }catch{
                    print(error)
                }
        } catch{
            print("data invalid")
        }
    }
}
            


