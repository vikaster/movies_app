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
//                    print(type(of: AirtableSearchResult))
//                    print(AirtableSearchResult)
                    self.movieDetails = AirtableSearchResult.records
                    
                }catch{
                    print(error)
                }
        } catch{
            print("data invalid")
        }
    }
    
    func addMovie() async {
        let movie = AirTableSecondFloor(id: "123456", fields: JSONInfo(id: "1123", title: "Terminator Genisys", year: "2015", actors: ["Emilia Clark"]))
        
        let apikey = ""
        if let url = URL(string: "https://api.airtable.com/v0/appTT0t4FupHVTbOf/tbl2qpwiUFVeocVFW"){
            do {
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let jsonMovie = try JSONEncoder().encode(movie)
                
                request.httpBody = jsonMovie
                //print(jsonMovie)
                
                let (_, response) = try await URLSession.shared.data(for: request)
                
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    print("All OK")
                    await fetchMovies()
                }
            } catch {
                print("Invalid data")
            }
        }
    }
}
            


