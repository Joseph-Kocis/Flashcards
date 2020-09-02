//
//  EditCardsView.swift
//  Flashcards
//
//  Created by Jody Kocis on 8/30/20.
//  Copyright © 2020 JodyKocis. All rights reserved.
//

import SwiftUI

class CardsInformation: ObservableObject {
    @Published var words: [String]
    @Published var definitions: [String]
    
    init() {
        words = [String]()
        definitions = [String]()
    }
    
    init(from cardSet: CardSet) {
        self.words = cardSet.cards.map { card in
            return card.word
        }
        self.definitions = cardSet.cards.map { card in
            return card.definition
        }
    }
    
    public func getCards() -> [Card] {
        var cards = [Card]()
        for index in words.indices {
            cards.append(Card(word: words[index], definition: definitions[index]))
        }
        return cards
    }
}

struct EditCardsView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var cardsInformation: CardsInformation
    
    public var body: some View {
        VStack {
            ForEach(cardsInformation.words.indices, id: \.self) { index in
                EditCardView(cardsInformation: self.cardsInformation, index: index)
            }
            Button(
                action: {
                    self.cardsInformation.words.append("")
                    self.cardsInformation.definitions.append("")
                },
                label: {
                    Image(systemName: "plus.circle")
                    .font(.custom("body", size: 25))
                }
            )
            .accentColor(appAccentColor)
        }
    }
}

struct EditCardsView_Previews: PreviewProvider {
    @State static var testCardSet: CardSet = CardSetsData.testCardSet()
    @State static var isCancelled = false
    static var previews: some View {
        EditCardSetView(cardSet: $testCardSet, isNewCardSet: true, isCancelled: $isCancelled)
            .environment(\.colorScheme, .light)
    }
}
