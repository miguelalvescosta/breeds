//
//  SearchListItemView.swift
//  DogBreeds
//
//  Created by Miguel Costa on 11.01.23.
//

import SwiftUI
struct SearchListItemView: View {
    
    var dogsItem: DogsItemViewData
    
    var body: some View {
    
        NavigationLink(destination: DogsDetailView(dogsItem: dogsItem)) {
                VStack(alignment: .leading, spacing: .zero) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 0) {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Breed Name").foregroundColor(.black)
                                Text(dogsItem.name).foregroundColor(.gray)
                            }
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Breed Group").foregroundColor(.black)
                                Text(dogsItem.group).foregroundColor(.gray)
                            }
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Origin").foregroundColor(.black)
                                Text(dogsItem.origin).foregroundColor(.gray)
                            }
                        }
                        .padding(.all, 12)
                        
                    }.background(Color.white)
                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: 1)
                }
            }

    }
}
