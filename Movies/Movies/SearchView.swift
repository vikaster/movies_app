//
//  SwiftUIView.swift
//  Movies
//
//  Created by yves on 22/06/2023.
//

import SwiftUI

struct SearchView: View {
    @State var text : String = ""
    @EnvironmentObject var movieVM: MovieSearchViewModel
    var body: some View {
        VStack(alignment: .center, spacing: 50) {
            Text("Recherches").font(.custom("Graphik", size: 32)).bold()
            HStack{
                TextField("Rechercher un film, un acteur, une actrice...", text:$text)
                    .font(.custom("Graphik compact", size: 14))
                    .padding([.top, .leading], 10)
                    .textSelection(.enabled)
                    .background(.white)
                    .cornerRadius(50)
                    .frame(maxWidth: .infinity, minHeight:22, maxHeight:22)
            }
            .padding()
            .frame(maxWidth: 348, minHeight: 48)
            .cornerRadius(10).background(.gray)
            .padding(.bottom, 10)
            
            
            
            Button(action: {
                Task {
                    await movieVM.fetchMovies()
                }
                
            }, label: {
                Text("Valider")
                    .foregroundColor(.gray)
                    .font(.custom("Graphik compact", size: 24))
        }).buttonStyle(.bordered)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(MovieSearchViewModel())
    }
}
