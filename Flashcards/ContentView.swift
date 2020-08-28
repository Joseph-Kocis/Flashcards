//
//  ContentView.swift
//  Flashcards
//
//  Created by Jody Kocis on 8/28/20.
//  Copyright © 2020 JodyKocis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    //@Environment(\.horizontalSizeClass) var sizeClass
    
    @State var currentPage = 0
    @State var cards = [
        CardView(),
        CardView(),
        CardView()
    ]
    
    var body: some View {
        NavigationView {
            PageView(cards, currentPage: $currentPage)
                .navigationBarTitle(
                    "Flashcards",
                    displayMode: .inline
                )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CardView: View {
    @State var front = "Front"
    @State var back = "Back"
    @State var showsFront = true
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(color: .black, radius: 5)
                .padding(.horizontal)
                .padding(.vertical, 50)
            Text(showsFront ? front : back)
            }
        .onTapGesture {
            self.showsFront.toggle()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
