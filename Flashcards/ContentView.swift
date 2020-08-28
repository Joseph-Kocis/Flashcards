//
//  ContentView.swift
//  Flashcards
//
//  Created by Jody Kocis on 8/28/20.
//  Copyright © 2020 JodyKocis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var currentPage = 0
    @State var cards = [
        CardView(front: "Word 1", back: "Definition 1"),
        CardView(front: "Word 2", back: "Definition 2"),
        CardView(front: "Word 3", back: "Definition 3")
    ]
    
    var body: some View {
        NavigationView {
            PageView(cards, currentPage: $currentPage)
                .navigationBarTitle(
                    "Flashcards",
                    displayMode: .inline
                )
                .edgesIgnoringSafeArea(.bottom)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CardView: View {
    let front: String
    let back: String
    @State var showsFront = true
    
    var body: some View {
        ZStack {
            CardDataView(
                front: front,
                back: back,
                isFront: true
            )
            .rotation3DEffect(.degrees(self.showsFront ? 0.0 : 180.0), axis: (x: 1.0, y: 0.0, z: 0.0))
            .zIndex(self.showsFront ? 1 : 0)
            
            CardDataView(
                front: front,
                back: back,
                isFront: false
            )
            .rotation3DEffect(.degrees(self.showsFront ? 180.0 : 0.0), axis: (x: -1.0, y: 0.0, z: 0.0))
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

struct CardDataView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.colorScheme) var colorScheme
    
    let front: String
    let back: String
    let isFront: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(
                    colorScheme == .light ? Color(UIColor.systemBackground) : Color(UIColor.tertiarySystemBackground)
                )
                .cornerRadius(10)
                .shadow(color: .gray, radius: 5)
                .padding(.horizontal, horizontalSizeClass == .compact ? 15 : 50)
                .padding(.vertical, 50)
            VStack {
                if !isFront {
                    Text(front)
                        .padding(.bottom, 15)
                    Text(isFront ? front : back)
                        .foregroundColor(isFront ? Color(UIColor.label) : Color(UIColor.secondaryLabel))
                } else {
                    Text(isFront ? front : back)
                        .foregroundColor(isFront ? Color(UIColor.label) : Color(UIColor.secondaryLabel))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .light
        )
    }
}
