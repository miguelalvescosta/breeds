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
            }
            .padding(.horizontal, 30)
        }
    }
}
