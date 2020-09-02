//
//  Data.swift
//  Flashcards
//
//  Created by Jody Kocis on 8/30/20.
//  Copyright © 2020 JodyKocis. All rights reserved.
//

import SwiftUI

let appAccentColor = Color(UIColor(named: "Accent Color")!)

struct CardSet {
    public let id = UUID()
    var title: String
    var cards: [Card]
}

struct Card: Identifiable {
    public let id = UUID()
    var word: String
    var definition: String
}

public class CardSetsData: ObservableObject {
    @Published var cardSets = [CardSet]()
    
    init() { }
    
    func addCardSet(_ cardSet: CardSet) {
        cardSets.append(cardSet)
    }
    
    func deleteCardSet(at index: Int) {
        cardSets.remove(at: index)
    }
    
    func updateCardSet(_ updatedCardSet: CardSet) {
        cardSets = cardSets.map { cardSet in
            if cardSet.id == updatedCardSet.id {
                return updatedCardSet
            } else {
                return cardSet
            }
        }
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
