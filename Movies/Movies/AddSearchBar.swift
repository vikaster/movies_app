//
//  AddSearchBar.swift
//  Movies
//
//  Created by yves on 27/06/2023.
//

import SwiftUI

struct AddSearchBar: View {
    @EnvironmentObject var movieVM: MovieSearchViewModel
    @State var text = ""
    var movies: [AirTableSecondFloor]?
    var body: some View {
        HStack{
            TextField("Rechercher un film, un acteur, une actrice...", text:$text)
                .font(.custom("Graphik compact", size: 14))
                .padding([.top, .leading], 10)
                .textSelection(.enabled)
                .background(.white)
                .cornerRadius(50)
                .frame(maxWidth: .infinity, minHeight:22, maxHeight:22)
                .onSubmit {
                    //action
                }
            Button(action: {
                Task{
                    await movieVM.addMovie()
                }
                
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
    }
}

struct AddSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        AddSearchBar()
    }
}
