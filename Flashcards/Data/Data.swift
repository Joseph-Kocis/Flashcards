//
//  Data.swift
//  Flashcards
//
//  Created by Jody Kocis on 8/30/20.
//  Copyright © 2020 JodyKocis. All rights reserved.
//

import SwiftUI
import CoreData
import Combine

let appAccentColor = Color(UIColor(named: "Accent Color")!)

struct CardSet: Identifiable {
    public var id = UUID()
    var title: String
    var cards: [Card]
}

struct Card: Identifiable {
    public var id = UUID()
    var word: String
    var definition: String
}

public class CardSetsData: ObservableObject {
    private var didSave = NotificationCenter.default.publisher(for: .NSManagedObjectContextDidSave)
    private var willSave = NotificationCenter.default.publisher(for: .NSManagedObjectContextWillSave)
    
    @Published var cardSets = [CardSet]() {
        didSet {
            save()
        }
    }
    
    // Update to use will save AND did save
    
    var onDidSave: AnyCancellable?
    var onWillSave: AnyCancellable?
    var startedSave = false
    var shouldFetch = false
    
    init() {
        onWillSave = willSave.sink { notification in
            if !self.startedSave {
                print("received changes - saving")
                self.shouldFetch = true
            } else {
                print("received changes - not saving")
            }
        }
        onDidSave = didSave.sink { notification in
            if self.shouldFetch {
                self.shouldFetch = false
                DispatchQueue.main.async {
                    self.fetchData()
                }
            }
        }
    }
    
    // MARK: Cards
    
    func addCardSet(_ cardSet: CardSet) {
        cardSets.append(cardSet)
    }
    
    func deleteCardSet(at index: Int) {
        cardSets.remove(at: index)
    }
    
    func updateCardSet(_ updatedCardSet: CardSet) {
        cardSets = cardSets.map { cardSet in
            if cardSet.id == updatedCardSet.id {
                return updatedCardSet
            } else {
                return cardSet
            }
        }
    }
    
    // MARK: Core Data
    
    private func createDataObject(fromEntity cardSetsEntity: CardSetsEntity) -> [CardSet] {
        guard let cardSetsEntities = cardSetsEntity.cardSets?.sortedArray(using: []) as? [CardSetEntity] else {
            return []
        }
        
        return cardSetsEntities.map { cardSetEntity in
            var cards = [Card]()
            if let cardsEntities = cardSetEntity.cards?.sortedArray(using: []) as? [CardEntity] {
                cards = cardsEntities.map { cardEntity in
                    return Card(id: cardEntity.id!, word: cardEntity.word!, definition: cardEntity.definition!)
                }
            }
            return CardSet(id: cardSetEntity.id!, title: cardSetEntity.title!, cards: cards)
        }
    }
    
    private func createManagedObject(withContext context: NSManagedObjectContext) {
        let cardSetsEntity = CardSetsEntity(context: context)
        cardSetsEntity.cardSets = NSSet(array: cardSets.map { cardSet in
            let cardSetEntity = CardSetEntity(context: context)
            cardSetEntity.id = cardSet.id
            cardSetEntity.title = cardSet.title
            cardSetEntity.cards = NSSet(array: cardSet.cards.map { card in
                let cardEntity = CardEntity(context: context)
                cardEntity.id = card.id
                cardEntity.word = card.word
                cardEntity.definition = card.definition
                return cardEntity
            })
            return cardSetEntity
        })
    }
    
    func fetchData() {
        if let results = AppDelegate.fetchCardSetsEntities() {
            guard let firstResult = results.first else { return }
            cardSets = createDataObject(fromEntity: firstResult)
        }
    }
    
    private func save() {
        startedSave = true
        createManagedObject(withContext: AppDelegate.context)
        AppDelegate.save()
        if let results = AppDelegate.fetchCardSetsEntities() {
            for index in results.startIndex ..< results.endIndex - 1 {
                AppDelegate.context.delete(results[index])
                AppDelegate.save()
            }
        }
        startedSave = false
    }
}

