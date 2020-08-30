//
//  ContentView.swift
//  Flashcards
//
//  Created by Jody Kocis on 8/28/20.
//  Copyright © 2020 JodyKocis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var currentPage = 0
    @State var cards = [
        CardView(
            card: Card(
                word: "Word 1",
                definition: "Definition 1"
            )
        ),
        CardView(
            card: Card(
                word: "Word 2",
                definition: "Definition 2"
            )
        ),
        CardView(
            card: Card(
                word: "Word 3",
                definition: "Definition 3"
            )
        )
    ]
    
    var body: some View {
        NavigationView {
            PageView(cards, currentPage: $currentPage)
                .navigationBarTitle(
                    "Flashcards",
                    displayMode: .inline
                )
                .edgesIgnoringSafeArea(.bottom)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .light
        )
    }
}
