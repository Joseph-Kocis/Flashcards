//
//  Data.swift
//  Flashcards
//
//  Created by Jody Kocis on 8/30/20.
//  Copyright © 2020 JodyKocis. All rights reserved.
//

import SwiftUI

class CardSetsData: ObservableObject {
    @Published var cardSets = [CardSet]()
    
    init() {
        addTestCardSet()
    }
    
    func addCardSet(_ cardSet: CardSet) {
        cardSets.append(cardSet)
    }
    
    private func addTestCardSet() {
        let testCards = [
            Card(
                word: "Word 1",
                definition: "Definition 1"
            ),
            Card(
                word: "Word 2",
                definition: "Definition 2"
            ),
            Card(
                word: "Word 3",
                definition: "Definition 3"
            )
        ]
        cardSets.append(
            CardSet(title: "Test Set", cards: testCards)
        )
    }
    
    
}
