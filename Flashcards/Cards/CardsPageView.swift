//
//  CardsPageView.swift
//  Flashcards
//
//  Created by Jody Kocis on 8/30/20.
//  Copyright © 2020 JodyKocis. All rights reserved.
//

import SwiftUI

struct CardsPageView: View {
    let cardSet: CardSet
    @State var currentPage = 0
    
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
            .edgesIgnoringSafeArea(.bottom)
    }
}

struct CardsPageView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .light)
    }
}
