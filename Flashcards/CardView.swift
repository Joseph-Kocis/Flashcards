//
//  CardView.swift
//  Flashcards
//
//  Created by Jody Kocis on 8/30/20.
//  Copyright © 2020 JodyKocis. All rights reserved.
//

import SwiftUI

struct CardView: View {
    let card: Card
    @State var showsFront = true
    
    var body: some View {
        ZStack {
            CardFrontView(card: card)
                .rotation3DEffect(
                    .degrees(self.showsFront ? 0.0 : -180.0),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                .zIndex(self.showsFront ? 1 : 0)
            
            CardBackView(card: card)
                .rotation3DEffect(
                    .degrees(self.showsFront ? -180.0 : 0.0),
                    axis: (x: 0.0, y: -1.0, z: 0.0)
                )
                .zIndex(self.showsFront ? 0 : 1)
        }
        .onTapGesture {
            withAnimation(.easeOut) {
                self.showsFront.toggle()
            }
        }
        .onDisappear {
            self.showsFront = true
        }
    }
    
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .light
        )
    }
}
