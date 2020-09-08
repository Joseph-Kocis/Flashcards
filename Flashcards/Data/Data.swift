//
//  Data.swift
//  Flashcards
//
//  Created by Jody Kocis on 8/30/20.
//  Copyright © 2020 JodyKocis. All rights reserved.
//

import SwiftUI
import CoreData

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
    @Published var cardSets = [CardSet]() {
        didSet {
            save()
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
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext,
            let entityName = CardSetsEntity.entity().name else {
            fatalError("Unable to read managed object context.")
        }
        do {
            let results = try context.fetch(NSFetchRequest(entityName: entityName)) as [CardSetsEntity]?
            guard let firstResult = results?.first else { return }
            cardSets = createDataObject(fromEntity: firstResult)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    private func save() {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            fatalError("Unable to read managed object context.")
        }
        
        createManagedObject(withContext: context)
        do {
            try context.save()
            let possibleResults = try context.fetch(NSFetchRequest(entityName: CardSetsEntity.entity().name!)) as [CardSetsEntity]?
            guard let results = possibleResults else { return }
            for index in results.startIndex ..< results.endIndex - 1 {
                context.delete(results[index])
                try context.save()
            }
        } catch {
            print(error)
        }
    }
}

