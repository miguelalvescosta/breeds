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
        NavigationView {
            VStack {
                TabButtonsView(currentPage: $currentPage, isEnabled: true, items: [PageMenuItem(title: "List "),
                     PageMenuItem(title: "Search")])
                .padding()
                switch currentPage {
                case 0:
                    VStack {
                        DogsListView(viewModel: DogsListViewModel())
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.clear)
                case 1:
                    VStack {
                       SearchView()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.red)
                default:
                    EmptyView()
                }
            }
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
