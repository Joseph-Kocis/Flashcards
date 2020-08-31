//
//  CreateCardSetView.swift
//  Flashcards
//
//  Created by Jody Kocis on 8/30/20.
//  Copyright © 2020 JodyKocis. All rights reserved.
//

import SwiftUI

struct CreateCardSetView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding public var newCardSet: CardSet?
    
    @State private var newCardSetTitle = ""
    
    @State private var newCards = [Card]()
    
    public init(newCardSet: Binding<CardSet?>) {
        self._newCardSet = newCardSet
    }
    
    public var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.secondarySystemBackground)
                VStack {
                    HStack {
                        Text("Title")
                        TextField("Enter title", text: $newCardSetTitle)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    AddCardsView(newCards: $newCards)
                    Spacer()
                }
                .padding()
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle("New Card Set", displayMode: .inline)
            .navigationBarItems(
                leading: Button(
                    action: {
                        self.presentationMode.wrappedValue.dismiss()
                    },
                    label: {
                        Text("Cancel")
                    }
                ),
                trailing: Button(
                    action: {
                        if !self.newCardSetTitle.isEmpty {
                            self.newCardSet = CardSet(
                                title: self.newCardSetTitle,
                                cards: self.newCards
                            )
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    },
                    label: {
                        Text("Add Set")
                    }
                )
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CreateCardSetView_Previews: PreviewProvider {
    @State static var testCardSet: CardSet? = CardSetsData.testCardSet()
    static var previews: some View {
        CreateCardSetView(newCardSet: $testCardSet)
            .environment(\.colorScheme, .light)
    }
}
