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
    @ObservedObject private var newCards = CardsInformation()
    
    @State private var showingAlert = false
    
    public init(newCardSet: Binding<CardSet?>) {
        self._newCardSet = newCardSet
    }
    
    public var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.secondarySystemBackground)
                ScrollView {
                    VStack {
                        HStack {
                            Text("Title")
                            TextField("Enter title", text: $newCardSetTitle)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        AddCardsView(cards: newCards)
                        Spacer()
                    }
                    .padding()
                }
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
                                cards: self.newCards.getCards()
                            )
                            self.presentationMode.wrappedValue.dismiss()
                        } else {
                            self.showingAlert = true
                        }
                    },
                    label: {
                        Text("Add Set")
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
