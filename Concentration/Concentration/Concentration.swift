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

    func chooseCard(at index: Int) {
        if cards[index].isFaceUp { // if face up, flip down
            cards[index].isFaceUp = false
        } else { // else, flip up
            cards[index].isFaceUp = true
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
