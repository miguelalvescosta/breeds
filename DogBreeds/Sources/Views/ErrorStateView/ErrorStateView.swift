//
//  ErrorStateView.swift
//  DogBreeds
//
//  Created by Miguel Costa on 10.01.23.
//

import SwiftUI

struct ErrorStateView: View {
    var viewData: EmptyStateViewData

    var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            Text("Something wrong")
            Button(action: {
                viewData.buttonTapped()
            }) {
                Text("Retry")
            }
            .padding(.horizontal, 30)
            .foregroundColor(.white)
            .background(.black)
        }
    }
}
