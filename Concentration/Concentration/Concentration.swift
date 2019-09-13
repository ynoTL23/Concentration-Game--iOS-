//
//  Concentration.swift
//  Concentration
//
//  Created by ynoTL on 9/5/19.
//

import Foundation

class Concentration {

    // init 'cards' array
    var cards = [Card]()

    var indexOfOneAndOnlyFaceUpCard: Int?

    func chooseCard(at index: Int) {
        // if card is not matched
        if !cards[index].isMatched {
            // if only one faceup and not the same index
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    // they match!
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up

                // reset
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                // new card selected
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }

    }

    init(numberOfPairsOfCards: Int) {

        // x..<value ==> range from 0 UP TO end-value
        // x...value ==> range from x to end-value, including end-value
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card] // copy cards into array

            // 'card' gets copied over into array 'cards'
            // cards.append(card)
            // cards.append(card)
        }

        // TODO: Shuffle the cards

    }

}