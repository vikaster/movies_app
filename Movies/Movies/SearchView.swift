//
//  SwiftUIView.swift
//  Movies
//
//  Created by yves on 22/06/2023.
//

import SwiftUI

struct SearchView: View {
    @State var text = ""
    var movies: [AirTableSecondFloor]?
    @EnvironmentObject var movieVM: MovieSearchViewModel
    var body: some View {
        VStack(alignment: .center, spacing: 50) {
            HStack{
                TextField("Rechercher un film, un acteur, une actrice...", text:$text)
                    .font(.custom("Graphik compact", size: 14))
                    .padding([.top, .leading], 10)
                    .textSelection(.enabled)
                    .background(.white)
                    .cornerRadius(50)
                    .frame(maxWidth: .infinity, minHeight:22, maxHeight:22)
                Button(action: {
                    // action
                    
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                        .font(.custom("Graphik compact", size: 24))
                }).buttonStyle(.plain)
            }
            .padding()
            .frame(maxWidth: 348, minHeight: 48)
            .cornerRadius(10).background(.gray)
            .padding(.bottom, 10)
            .onAppear {
                Task{
                    await movieVM.fetchMovies()
                }
            }
            Text("Movies")
                    .font(.largeTitle)
                if let movies = movieVM.movieDetails {
                    ForEach(movies){movie in
                        HStack{
                            Text(movie.fields.title)
                                .font(.title)
                            Text(movie.fields.year)
                                .font(.title2)
                            Text(String(movie.fields.actors.first!))
                        }.padding()
                            .frame(maxWidth: 348, minHeight: 48)
                            .cornerRadius(10).background(.gray)
                            .padding(.bottom, 10)
                    }
                }
            
        }
//        .refreshable{
//            await movieVM.fetchMovies()
//        }
    }
}
    
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
