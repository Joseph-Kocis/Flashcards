//
//  CardsPageView.swift
//  Flashcards
//
//  Created by Jody Kocis on 8/30/20.
//  Copyright © 2020 JodyKocis. All rights reserved.
//

import SwiftUI

struct CardsPageView: View {
    @ObservedObject public var cardSetsData: CardSetsData
    
    @State var currentPage = 0
    @State var showingEditItemView = false
    
    @State var cardSet: CardSet
    @State var editedCardSet: CardSet? = nil
    
    var body: some View {
        PageView(
            cardSet.cards.map { card in return CardView(card: card)},
            currentPage: self.$currentPage,
            failView: AnyView(
                Text("No Cards")
                    .foregroundColor(Color(UIColor.secondaryLabel))
                    .navigationBarTitle("\(cardSet.title)", displayMode: .inline)
                    .font(Font.headline)
            )
        )
            .navigationBarTitle(
                "\(cardSet.title)",
                displayMode: .inline
            )
            .navigationBarItems(
                trailing: Button(
                    action: {
                        self.editedCardSet = self.cardSet
                        self.showingEditItemView = true
                    },
                    label: {
                        Text("Edit")
                    }
                )
                .sheet(isPresented: $showingEditItemView) {
                    EditCardSetView(
                        cardSet: self.$editedCardSet,
                        isNewCardSet: false
                    )
                    .onDisappear {
                        if let editedCardSet = self.editedCardSet {
                            self.cardSet = editedCardSet
                            // TODO: Save the card set
                        }
                        self.editedCardSet = nil
                    }
                }
            )
            .edgesIgnoringSafeArea(.bottom)
    }
}

struct CardsPageView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .light)
    }
}
