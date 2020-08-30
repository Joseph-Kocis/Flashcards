//
//  ContentView.swift
//  Flashcards
//
//  Created by Jody Kocis on 8/28/20.
//  Copyright © 2020 JodyKocis. All rights reserved.
//

import SwiftUI

struct CardSet {
    let title: String
    let cards: [Card]
}

struct Card {
    let word: String
    let definition: String
}

struct ContentView: View {
    @ObservedObject var cardSetsData = CardSetsData()
    @State var currentPage = 0
    
    var body: some View {
        NavigationView {
            
            
            
            
            
            PageView(
                cardSetsData.cardSets.first!.cards.map { card in return CardView(card: card)},
                currentPage: $currentPage
            )
                .navigationBarTitle(
                    "Flashcards",
                    displayMode: .inline
                )
                .edgesIgnoringSafeArea(.bottom)
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .light
        )
    }
}
