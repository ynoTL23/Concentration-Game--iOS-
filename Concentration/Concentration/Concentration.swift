//
//  Concentration.swift
//  Concentration
//
//  Created by ynoTL on 9/5/19.
//

import Foundation

class Concentration {
    
    // Holds all cards
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard : Int?

    func chooseCard(at index: Int) {
        
        if !cards[index].isMatched {
            // if only one card face up and flips another card ==> if both true
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    // this means both cards match
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // else, there are 0 or 2 cards face up, and dont match
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
    }
    
    init(numberOfPairsOfCards : Int) {
        // x..y = range, not including y
        // x...y = range, including y
        
        // Create cards for the game
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            
            // Add card to array / board
            cards += [card, card]
        }
        // TODO: Shuffle the cards in init()
    }
    
}
