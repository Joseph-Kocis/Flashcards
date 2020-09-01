//
//  FullCardView.swift
//  Flashcards
//
//  Created by Jody Kocis on 9/1/20.
//  Copyright © 2020 JodyKocis. All rights reserved.
//

import SwiftUI

struct FullCardView: View {
    @Environment(\.colorScheme) var colorScheme
    
    public var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(
                 colorScheme == .light ? Color(UIColor.systemBackground) : Color(UIColor.tertiarySystemBackground)
                )
                .frame(minHeight: 125, maxHeight: .infinity)
                .cornerRadius(10)
                .shadow(color: self.colorScheme == .light ? .gray : .black, radius: 2)
                .padding(.vertical, 10)
            
            HStack {
                Text("Word sdfads")
                    .frame(minWidth: 0, maxWidth: .infinity)
                Text("Definition sdfadfasdfasd")
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            
            HStack {
                Divider()
                    .padding(.vertical, 10)
            }
        }
    }
}

struct FullCardView_Previews: PreviewProvider {
    @State static var testCardSet: CardSet? = CardSetsData.testCardSet()
    static var previews: some View {
        CreateCardSetView(newCardSet: $testCardSet)
            .environment(\.colorScheme, .light)
    }
}
