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
    @State var addItemCancelled = false
    
    @State var cardSet: CardSet
    
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
                        self.showingEditItemView = true
                    },
                    label: {
                        Text("Edit")
                    }
                )
                .sheet(isPresented: $showingEditItemView) {
                    EditCardSetView(
                        cardSet: self.$cardSet,
                        isNewCardSet: false,
                        isCancelled: self.$addItemCancelled
                    )
                    .onDisappear {
                        if !self.addItemCancelled {
                            self.cardSetsData.updateCardSet(self.cardSet)
                        }
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
