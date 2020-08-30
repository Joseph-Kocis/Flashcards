//
//  CardDataViews.swift
//  Flashcards
//
//  Created by Jody Kocis on 8/30/20.
//  Copyright © 2020 JodyKocis. All rights reserved.
//

import SwiftUI

struct CardFrontView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.colorScheme) var colorScheme
    
    let card: Card
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(
                    colorScheme == .light ? Color(UIColor.systemBackground) : Color(UIColor.tertiarySystemBackground)
                )
                .cornerRadius(10)
                .shadow(color: colorScheme == .light ? .gray : .black, radius: 5)
                .padding(.horizontal, horizontalSizeClass == .compact ? 15 : 50)
                .padding(.vertical, 50)
            Text(card.word)
                .foregroundColor(Color(UIColor.label))
        }
    }
}

struct CardBackView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.colorScheme) var colorScheme
    
    let card: Card
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(
                    colorScheme == .light ? Color(UIColor.systemBackground) : Color(UIColor.tertiarySystemBackground)
                )
                .cornerRadius(10)
                .shadow(color: colorScheme == .light ? .gray : .black, radius: 5)
                .padding(.horizontal, horizontalSizeClass == .compact ? 15 : 50)
                .padding(.vertical, 50)
            VStack {
                Text(card.word)
                    .padding(.bottom, 15)
                Text(card.definition)
                    .foregroundColor(Color(UIColor.secondaryLabel))
            }
        }
    }
}

struct FrontCardView_Previews: PreviewProvider {
    static var previews: some View {
        CardBackView(card: Card(word: "Word", definition: "Definition"))
            .environment(\.colorScheme, .light)
    }
}

struct BackCardView_Previews: PreviewProvider {
    static var previews: some View {
        CardBackView(card: Card(word: "Word", definition: "Definition"))
            .environment(\.colorScheme, .light)
    }
}
