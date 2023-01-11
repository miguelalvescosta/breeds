//
//  DogsListItemView.swift
//  DogBreeds
//
//  Created by Miguel Costa on 10.01.23.
//

import SwiftUI
struct DogsListItemView: View {
    
    var dogsItem: DogsItemViewData
    
    var body: some View {
        NavigationLink(destination: DogsDetailView(dogsItem: dogsItem)) {
                VStack(alignment: .leading, spacing: .zero) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(alignment: .top) {
                                AsyncImage(
                                    url: URL(string: dogsItem.image),
                                    content: { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 80, height: 80)
                                    },
                                    placeholder: {
                                        ProgressView()
                                    }
                                )
                                Spacer()
                                Text(dogsItem.name)
                                    .font(.system(.caption, design: .rounded))
                                    .multilineTextAlignment(.trailing)
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
