//
//  EditCardView.swift
//  Flashcards
//
//  Created by Jody Kocis on 9/1/20.
//  Copyright © 2020 JodyKocis. All rights reserved.
//

import SwiftUI

struct EditCardView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var cardsInformation: CardsInformation
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
            
            if self.cardsInformation.words.indices.contains(index) && self.cardsInformation.definitions.indices.contains(index) {
                HStack {
                    TextField("Enter word", text: self.$cardsInformation.words[index])
                        .padding(.horizontal, 10)
                        .multilineTextAlignment(.center)
                    TextField("Enter definition", text: self.$cardsInformation.definitions[index])
                        .padding(.horizontal, 10)
                        .multilineTextAlignment(.center)
                }
            }
            
            HStack {
                Divider()
            }
            
            HStack {
                VStack {
                    Button(
                        action: {
                            self.cardsInformation.words.remove(at: self.index)
                            self.cardsInformation.definitions.remove(at: self.index)
                        },
                        label: {
                            Image(systemName: "minus.circle.fill")
                            .foregroundColor(.red)
                            .background(Color.white.cornerRadius(50))
                            .font(.custom("body", size: 25))
                        }
                    )
                    Spacer()
                }
                Spacer()
            }
            .padding(.vertical, -7)
            .padding(.horizontal, -7)
        }
        .padding(.vertical, 10)
    }
}

struct EditCardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .light)
    }
}
