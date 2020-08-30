//
//  PageView.swift
//  Flashcards
//
//  Created by Jody Kocis on 8/28/20.
//  Copyright © 2020 JodyKocis. All rights reserved.
//

import SwiftUI
import UIKit

struct PageView<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]
    @Binding var currentPage: Int
    let failView: AnyView
    
    init(_ views: [UIHostingController<Page>], currentPage: Binding<Int>, failView: AnyView) {
        self._currentPage = currentPage
        self.viewControllers = views
        self.failView = failView
    }
    
    init(_ views: [Page], currentPage: Binding<Int>, failView: AnyView) {
        self._currentPage = currentPage
        self.viewControllers = views.map {
            return UIHostingController(rootView: $0)
        }
        self.failView = failView
    }

    var body: some View {
        if (self.viewControllers.count > 0) {
            return AnyView(VStack {
                PageViewController(
                    controllers: self.viewControllers,
                    currentPage: self.$currentPage
                )
            })
        }
        return failView
    }
}

struct PageView_Previews: PreviewProvider {
    @State static var page = 0
    static var previews: some View {
        PageView(
            [Text("Testing")],
            currentPage: $page,
            failView: AnyView(
                Text("No Cards")
                    .foregroundColor(Color(UIColor.secondaryLabel))
                    .navigationBarTitle("Flashcards", displayMode: .inline)
                    .font(Font.headline)
            )
        )
    }
}

