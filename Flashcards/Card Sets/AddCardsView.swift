//
//  AddCardsView.swift
//  Flashcards
//
//  Created by Jody Kocis on 8/30/20.
//  Copyright © 2020 JodyKocis. All rights reserved.
//

import SwiftUI

class CardsInformation: ObservableObject {
    @Published var words = [String]()
    @Published var definitions = [String]()
    
    public func getCards() -> [Card] {
        var cards = [Card]()
        for index in words.indices {
            cards.append(Card(word: words[index], definition: definitions[index]))
        }
        return cards
    }
}

struct AddCardsView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var cards: CardsInformation
    
    public var body: some View {
        VStack {
            ForEach(cards.words.indices, id: \.self) { index in
                FullCardView(cards: self.cards, index: index)
            }
            Button(
                action: {
                    self.cards.words.append("")
                    self.cards.definitions.append("")
                },
                label: {
                    Image(systemName: "plus.circle")
                    .font(.custom("body", size: 25))
                }
            )
        }
    }
}

struct AddCardsView_Previews: PreviewProvider {
    @State static var testCardSet: CardSet? = CardSetsData.testCardSet()
    static var previews: some View {
        CreateCardSetView(newCardSet: $testCardSet)
            .environment(\.colorScheme, .light)
    }
}
