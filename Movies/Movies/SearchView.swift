//
//  SwiftUIView.swift
//  Movies
//
//  Created by yves on 22/06/2023.
//

import SwiftUI

struct SearchView: View {
    @State var movieSearched: [AirTableSecondFloor]? = []
    @State var textContent: String = "Movie"
    @State var btnclick:Bool = false
    var movies: [AirTableSecondFloor]? = [AirTableSecondFloor(fields: JSONInfo(title: "Asterix", year: "2000"))]
    @EnvironmentObject var movieVM: MovieSearchViewModel
    var body: some View {
        VStack(alignment: .center) {
            
        NavigationView(content: {
            
            NavigationLink(destination:{
                AddSearchBar(textContent: $textContent, btnSate:$btnclick)
                // if btnclick then view searchList
                if(btnclick){
                    SearchResults(textToSearch: $textContent)
                }}, label: {
                VStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 10).stroke()
                            .foregroundColor(.gray).frame(width:299, height:48).padding(10)
                        Text("Search movies").foregroundColor(.mint)
                                .font(.largeTitle)
                    }
                }
            })
            AddSearchBar(textContent: $textContent, btnSate:$btnclick)
        })

            
            
        }
//        .refreshable{
//            await movieVM.fetchMovies()
//        }
    }
}

struct SearchResults: View {
    @Binding var textToSearch: String
    @EnvironmentObject var movieVM: MovieSearchViewModel
    var movies: [AirTableSecondFloor]?
    var body: some View{
        VStack{
            if let movies = movieVM.movieSearched{
                List(movies){ movie in
                    HStack{
                        Text(movie.fields.title)
                            .font(.title)
                        Text(movie.fields.year)
                            .font(.title2)
                        //Text(String(movie.fields.actors.first!))
                    }.padding()
                        .frame(maxWidth: 348, minHeight: 48)
                        .cornerRadius(10).background(.gray)
                        .padding(.bottom, 10)
                }
                .navigationTitle("Search results").navigationBarTitleDisplayMode(.large)
            }
        }
        .onAppear{
            Task{
                await movieVM.searchMovies(movieToSearch: textToSearch)
            }
       }
    }
}
    
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(MovieSearchViewModel())
    }
}
