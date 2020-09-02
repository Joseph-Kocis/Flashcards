//
//  EditCardView.swift
//  Flashcards
//
//  Created by Jody Kocis on 9/1/20.
//  Copyright © 2020 JodyKocis. All rights reserved.
//

import SwiftUI

struct EditCardView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var cards: CardsInformation
    let index: Int
    
    public var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(
                 colorScheme == .light ? Color(UIColor.systemBackground) : Color(UIColor.tertiarySystemBackground)
                )
                .frame(minHeight: 125, maxHeight: .infinity)
                .cornerRadius(10)
                .shadow(color: self.colorScheme == .light ? .gray : .black, radius: 2)
            
            HStack {
                TextField("Enter word", text: self.$cards.words[index])
                    .padding(.horizontal, 10)
                    .multilineTextAlignment(.center)
                TextField("Enter definition", text: self.$cards.definitions[index])
                    .padding(.horizontal, 10)
                    .multilineTextAlignment(.center)
            }
            
            HStack {
                Divider()
                    
            }
        }
        .padding(.vertical, 10)
    }
}

struct EditCardView_Previews: PreviewProvider {
    @State static var testCardSet: CardSet? = CardSetsData.testCardSet()
    static var previews: some View {
        EditCardSetView(cardSet: $testCardSet, isNewCardSet: true)
            .environment(\.colorScheme, .light)
    }
}
