//
//  Data.swift
//  Flashcards
//
//  Created by Jody Kocis on 8/30/20.
//  Copyright © 2020 JodyKocis. All rights reserved.
//

import SwiftUI

public class CardSetsData: ObservableObject {
    @Published var cardSets = [CardSet]()
    
    init() {
        addTestCardSet()
        addTestCardSet()
        addTestCardSet()
    }
    
    func addCardSet(_ cardSet: CardSet) {
        cardSets.append(cardSet)
    }
    
    private func addTestCardSet() {
        cardSets.append(CardSetsData.testCardSet())
    }
    
    static func testCardSet() -> CardSet {
        return CardSet(
            title: "Test Set",
            cards: [
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
        )
    }
}
