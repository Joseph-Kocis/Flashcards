//
//  EditCardSetView.swift
//  Flashcards
//
//  Created by Jody Kocis on 8/30/20.
//  Copyright © 2020 JodyKocis. All rights reserved.
//

import SwiftUI

struct EditCardSetView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject private var cardsInformation = CardsInformation()
    
    @State private var cardSetTitle = ""
    @State private var showingAlert = false
    
    @Binding var cardSet: CardSet
    @Binding var isCancelled: Bool
    
    var isNewCardSet: Bool
    
    public init(cardSet: Binding<CardSet>, isNewCardSet: Bool, isCancelled: Binding<Bool>) {
        self._cardSet = cardSet
        self.isNewCardSet = isNewCardSet
        self._isCancelled = isCancelled
        self.cardsInformation = CardsInformation(from: cardSet.wrappedValue)
    }
    
    public var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.secondarySystemBackground)
                ScrollView {
                    VStack {
                        HStack {
                            Text("Title")
                            TextField(
                                "Enter title",
                                text: $cardSetTitle
                            )
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        EditCardsView(cards: cardsInformation)
                        Spacer()
                    }
                    .padding()
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle(isNewCardSet ? "New Card Set" : "Edit Card Set", displayMode: .inline)
            .navigationBarItems(
                leading: Button(
                    action: {
                        self.isCancelled = true
                        self.presentationMode.wrappedValue.dismiss()
                    },
                    label: {
                        Text("Cancel")
                    }
                ),
                trailing: Button(
                    action: {
                        if !self.cardSetTitle.isEmpty {
                            self.cardSet.title = self.cardSetTitle
                            self.cardSet.cards = self.cardsInformation.getCards()
                            self.isCancelled = false
                            self.presentationMode.wrappedValue.dismiss()
                        } else {
                            self.showingAlert = true
                        }
                    },
                    label: {
                        Text(isNewCardSet ? "Add Set" : "Done")
                    }
                )
            )
            .alert(isPresented: self.$showingAlert) {
                Alert(
                    title: Text("Cannot Add Set"),
                    message: Text("This set needs a title before it can be added"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .onAppear {
            self.cardSetTitle = self.cardSet.title
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct EditCardSetView_Previews: PreviewProvider {
    @State static var testCardSet: CardSet = CardSetsData.testCardSet()
    @State static var isCancelled = false
    static var previews: some View {
        EditCardSetView(cardSet: $testCardSet, isNewCardSet: true, isCancelled: $isCancelled)
            .environment(\.colorScheme, .light)
    }
}
