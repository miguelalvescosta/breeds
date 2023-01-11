//
//  SearchView.swift
//  DogBreeds
//
//  Created by Miguel Costa on 11.01.23.
//

import Foundation
import SwiftUI
struct SearchView: View {
    let names = ["Holly allah", "Josh", "Rhonda", "Ted"]
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            if !searchText.isEmpty {
                List {
                    ForEach(searchResults, id: \.self) { name in
                        Text(name)
                    }
                }
            }
        }
        .searchable(text: $searchText)
    }

    var searchResults: [String] {
        if searchText.isEmpty {
            return names
        } else {
            return names.filter { $0.contains(searchText) }
        }
    }
}
