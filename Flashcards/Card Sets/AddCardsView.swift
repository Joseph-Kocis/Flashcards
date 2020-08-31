//
//  AddCardsView.swift
//  Flashcards
//
//  Created by Jody Kocis on 8/30/20.
//  Copyright © 2020 JodyKocis. All rights reserved.
//

import SwiftUI

// Try creating an array of Binding

// Create a State array of Strings
// Manually create the Bindings, using index https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-custom-bindings

struct AddCardsView: View {
    @State var cardWords = [String]()
    @State var cardDefinitions = [String]()
    
    @Binding var cards: [Card]
    
    public init(newCards: Binding<[Card]>) {
        self._cards = newCards
    }
    
    public var body: some View {
        VStack {
      
            ForEach(cardWords.indices, id: \.self) { index in
                VStack {
                    HStack {
                        Text("Word")
                        TextField("Enter word", text: self.$cardWords[index])
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    HStack {
                        Text("Definition")
                        TextField("Enter definition", text: self.$cardDefinitions[index])
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
            }
            
            
            /*ForEach(cards) { card in
                VStack {
                    HStack {
                        Text("Word")
                        TextField("Enter word", text: card.$word)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    HStack {
                        Text("Definition")
                        TextField("Enter definition", text: card.$definition)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
            }*/
            Button(
                action: {
                    self.cardWords.append("Word")
                    self.cardDefinitions.append("Definition")
                },
                label: {
                    Image(systemName: "plus.circle")
                    .font(.custom("body", size: 25))
                }
            )
            Button(
                action: {
                    self.updateCards()
                },
                label: {
                    Text("Update")
                }
            )
        }
    }
    
    public func updateCards(){
        var cards = [Card]()
        for index in cardWords.indices {
            cards.append(Card(word: cardWords[index], definition: cardDefinitions[index]))
        }
        self.cards = cards
    }
}

struct AddCardsView_Previews: PreviewProvider {
    @State static var testCardSet: CardSet? = CardSetsData.testCardSet()
    static var previews: some View {
        CreateCardSetView(newCardSet: $testCardSet)
            .environment(\.colorScheme, .light)
    }
}
