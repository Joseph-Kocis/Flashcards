//
//  ContentView.swift
//  Flashcards
//
//  Created by Jody Kocis on 8/28/20.
//  Copyright © 2020 JodyKocis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var cardSetsData = CardSetsData()
    
    var body: some View {
        NavigationView {
            CardSetsView(cardSetsData: cardSetsData)
            
            Text("No Card Set Selected")
                .foregroundColor(Color(UIColor.secondaryLabel))
                .font(Font.headline)
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .light)
    }
}
