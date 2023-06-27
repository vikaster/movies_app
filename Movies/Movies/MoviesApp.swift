//
//  MoviesApp.swift
//  Movies
//
//  Created by Apprenant83 on 21/06/2023.
//

import SwiftUI

@main
struct MoviesApp: App {
    @StateObject var movieVM: MovieSearchViewModel = MovieSearchViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(movieVM)
        }
    }
}
