//
//  DogsDetailView.swift
//  DogBreeds
//
//  Created by Miguel Costa on 10.01.23.
//

import SwiftUI
struct DogsDetailView: View {
    var dogsItem: DogsItemViewData
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Breed Name").font(.title)
                    Text(dogsItem.name).foregroundColor(.gray)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text("Breed Category").font(.title)
                    Text(dogsItem.category).foregroundColor(.gray)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text("Origin").font(.title)
                    Text(dogsItem.origin).foregroundColor(.gray)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text("Temperament").font(.title)
                    Text(dogsItem.temperament).foregroundColor(.gray)
                }
                
            }
        }
    }
}

