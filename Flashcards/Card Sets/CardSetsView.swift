//
//  CardSetsView.swift
//  Flashcards
//
//  Created by Jody Kocis on 8/30/20.
//  Copyright © 2020 JodyKocis. All rights reserved.
//

import SwiftUI

public struct CardSetsView: View {
    @ObservedObject public var cardSetsData: CardSetsData
    
    @State var showingAddItemView = false
    @State var addItemCancelled = false
    @State var newCardSet: CardSet = CardSet(title: "", cards: [])
    
    public init(cardSetsData: CardSetsData) {
        self.cardSetsData = cardSetsData
    }
    
    public var body: some View {
        List {
            ForEach(cardSetsData.cardSets, id: \.id) { cardSet in
                NavigationLink(destination: CardsPageView(cardSetsData: self.cardSetsData, cardSet: cardSet)) {
                    Text(cardSet.title)
                }
            }
            .onDelete { indexSet in
                for index in indexSet {
                    self.cardSetsData.deleteCardSet(at: index)
                }
            }
        }
        .navigationBarTitle("Card Sets", displayMode: .inline)
        .navigationBarItems(
            leading: EditButton(),
            trailing: Button(
                action: {
                    self.newCardSet = CardSet(title: "", cards: [])
                    self.showingAddItemView.toggle()
                },
                label: {
                    Image(systemName: "plus")
                    .font(.custom("body", size: 20))
                }
            )
            .sheet(isPresented: $showingAddItemView) {
                EditCardSetView(
                    cardSet: self.$newCardSet,
                    isNewCardSet: true,
                    isCancelled: self.$addItemCancelled
                )
                .onDisappear() {
                    if !self.addItemCancelled && !self.newCardSet.title.isEmpty {
                        self.cardSetsData.addCardSet(self.newCardSet)
                    }
                    self.newCardSet = CardSet(title: "", cards: [])
                }
            }
        )
    }
    
}

struct CardSetsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .light)
    }
}
