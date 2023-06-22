//
//  TabBarView.swift
//  Movies
//
//  Created by yves on 22/06/2023.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView{
            SearchView()
                .tabItem{
                    Label("Recherche", systemImage: "magnifyingglass")
                }
            FavorisView()
                .tabItem{
                    Label("Favoris", systemImage: "bookmark")
                }
            
        }.accentColor(Color("myColor"))
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
