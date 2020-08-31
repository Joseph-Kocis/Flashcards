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
    @State var newCardSet: CardSet? = nil
    
    public init(cardSetsData: CardSetsData) {
        self.cardSetsData = cardSetsData
    }
    
    public var body: some View {
        List {
            ForEach(cardSetsData.cardSets, id: \.id) { cardSet in
                NavigationLink(destination: CardsPageView(cardSet: cardSet)) {
                    Text(cardSet.title)
                }
            }
        }
        .navigationBarTitle("Card Sets", displayMode: .inline)
        .navigationBarItems(
            trailing: Button(
                action: {
                    self.newCardSet = nil
                    self.showingAddItemView.toggle()
                },
                label: {
                    Image(systemName: "plus")
                    .font(.custom("body", size: 20))
                }
            )
            .sheet(isPresented: $showingAddItemView) {
                CreateCardSetView(newCardSet: self.$newCardSet)
                    .onDisappear() {
                        if let newCardSet = self.newCardSet {
                            self.cardSetsData.addCardSet(newCardSet)
                            self.newCardSet = nil
                        }
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
