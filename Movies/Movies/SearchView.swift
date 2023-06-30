//
//  SwiftUIView.swift
//  Movies
//
//  Created by yves on 22/06/2023.
//

import SwiftUI

struct SearchView: View {
    @State var movieSearched: [AirTableSecondFloor]? = []
    @State var textContent: String = ""
    @State var btnclick:Bool = false
    var movies: [AirTableSecondFloor]? = [AirTableSecondFloor(fields: JSONInfo(title: "Asterix", year: "2000"))]
    @EnvironmentObject var movieVM: MovieSearchViewModel
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color("Background"))
                .ignoresSafeArea(.all)
            VStack(alignment:.center){
                AddSearchBar(textContent: $textContent, btnState: $btnclick)
                NavigationView(content: {
                    // Affiche ma SearchBar
                    VStack{
                        if(!btnclick){
                            Text("Rechercher un film, un acteur, une actrice...").foregroundColor(.black)
                                .font(.custom("Graphik compact", size: 24))
                        }
                        
                            if(btnclick){
                                SearchResults(textToSearch: $textContent)
                            }
                        
                    }
                    NavigationLink(destination:{
                    }, label: {
                        VStack{
                            HStack{
                                Image(systemName: "arrow.clockwise")
                                    .foregroundColor(.black)
                                    .font(.largeTitle)
                                    .frame(width:20, height: 20)
                            }
                            ZStack{
                                RoundedRectangle(cornerRadius: 10).foregroundColor(Color("Background")).frame(width:299, height:48).padding(10)
                                    .foregroundColor(.black)
                                
                                Text("Searching movies").foregroundColor(.white)
                                    .font(.system(size: 24))
                                
                            }
                        }
                    })
                })
                //.foregroundColor(.white)
                
                
                
            }
            //        .refreshable{
            //            await movieVM.fetchMovies()
            //        }
        }
        } // fin de ma ZStack
        
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
