//
//  ContentView.swift
//  DogBreeds
//
//  Created by Miguel Costa on 10.01.23.
//

import SwiftUI

struct ContentView: View {
    @State var currentPage = 0
    
    var body: some View {
            TabView {
                VStack {
                    DogsListView()
                }
                .tabItem {
                    Label("List", systemImage: "list.dash")
                }
                VStack {
                    SearchView()
                }
                .tabItem {
                    Label("Search", systemImage: "tray.and.arrow.up.fill")
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
