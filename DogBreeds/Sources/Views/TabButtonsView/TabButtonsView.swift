//
//  TabButtonsView.swift
//  DogBreeds
//
//  Created by Miguel Costa on 10.01.23.
//

import Foundation
import SwiftUI

struct TabButtonsView: View {
    @Binding var currentPage: Int
    private var isEnabled: Bool
    var items: [TabButtonsItemType]
    var action: (() -> Void)?

    init(currentPage: Binding<Int>,
         isEnabled: Bool,
         items: [TabButtonsItemType],
         action: (() -> Void)? = nil) {
        self._currentPage = currentPage
        self.isEnabled = isEnabled
        self.items = items
        self.action = action
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                HStack {}
                .frame(width: geometry.size.width, height: 56.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 8.0)
                        .stroke(Color.black, lineWidth: 1)
                )
                HStack {
                    ForEach(Array(items).indices, id: \.self) { index in
                        Button(action: {
                            guard isEnabled else { return }
                            currentPage = index
                            action?()
                        }) {
                            VStack {
                                if currentPage == index {
                                    Text(items[index].title)
                                        
                                        .foregroundColor(Color.black)
                                } else {
                                    Text(items[index].title)
                                        .foregroundColor(Color.black)
                                }
                            }
                        }
                        .frame(width: (geometry.size.width / CGFloat(items.count)) - 5.0, height: 52.0)
                        .if(currentPage == index, content: { button in
                            button
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8.0)
                                        .stroke(Color.black, lineWidth: 5)
                                )
                        })
                    }
                }
            }
        }
        .frame(height: 56.0)
    }
}


protocol TabButtonsItemType {
    var title: String { get }
}

struct RCHPageMenuItem: TabButtonsItemType {
    let title: String
}

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }
}
