//
//  AddSearchBar.swift
//  Movies
//
//  Created by yves on 27/06/2023.
//

import SwiftUI

struct AddSearchBar: View {
    @EnvironmentObject var movieVM: MovieSearchViewModel
    @Binding var textContent: String
    @Binding var btnSate: Bool
    var body: some View {
        HStack{
            TextField("Rechercher un film, un acteur, une actrice...", text:$textContent)
                .font(.custom("Graphik compact", size: 24))
                .padding([.top, .leading], 10)
                .textSelection(.enabled)
                .background(.white)
                .cornerRadius(50)
                .frame(maxWidth: .infinity, minHeight:28, maxHeight:28)
                .onSubmit {
                    //action
                    Task{
                        await movieVM.searchMovies(movieToSearch: textContent)
                    }
                    self.btnSate.toggle()
                }
            Button(action: {
                // do nothing
                self.btnSate.toggle()
                
            }, label: {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.black)
                    .shadow(color: .black, radius:1)
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
        AddSearchBar(textContent: .constant(""), btnSate: .constant(false))
    }
}
