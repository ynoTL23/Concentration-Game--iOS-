//
//  Concentration.swift
//  Concentration
//
//  Created by ynoTL on 9/5/19.
//

import Foundation

class Concentration {

    // init 'cards' array
    private(set) var cards = [Card]()
    private var seenBefore: [Int] = []
    private var initialMove: Date!
    
    private(set) var flipCount: Int
    private(set) var playerScore: Int
    
    // return the one and only face up card
    // if there isnt JUST one face up card, return nil
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var cardFoundIndex : Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if cardFoundIndex == nil {
                        cardFoundIndex = index
                    } else {
                        cardFoundIndex = nil
                    }
                }
            }
            return cardFoundIndex
        }
        
        // new index of the only card face up
        set(newValue) {
            for index in cards.indices {
                // if index is equal newValue, card at particular will be true
                // else, set false
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }

    internal func chooseCard(at index: Int) {
        // error handle
        // check if current index is in 'cards' arrays
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): chosen index not valid")
        // else, print error statement and crash app
        
        flipCount += 1 // card flipped over
        
        // if card is not matched
        if !cards[index].isMatched {
            
            // check if card has been seen before
            if seenBefore.contains(cards[index].identifier) {
                // Extra credit: Points based on time
                let differenceInTime = initialMove.timeIntervalSince(initialMove) // returns a Double
                // 5 = max points to be deducted
                let calculatedPenalty = Int((5) / (differenceInTime + 1)) // (+ 1) avoid division by zero
                print("Penalty -\(calculatedPenalty)")
                
                playerScore -= calculatedPenalty
                
                initialMove = Date()
            } else {
                // else, add it to list of cards that have been seen before
                seenBefore.append(cards[index].identifier)
            }
            // if only one faceup and not the same index
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    // THEY MATCH!
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    // Extra credit: Points based on time
                    let differenceInTime = initialMove.timeIntervalSince(initialMove)
                    // 10 = max points to be rewarded
                    let calculatedReward = Int((20) / (differenceInTime + 1))
                    print("Reward +\(calculatedReward)")
                    
                    playerScore += calculatedReward // give 2 pts
                    
                    initialMove = Date()
                }
                cards[index].isFaceUp = true
            } else {
                // either no cards or 2 cards are face up
                // so set the only card's index
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
    }

    init(numberOfPairsOfCards: Int) {
        flipCount = 0
        playerScore = 0
        
        // error handle, make sure num of cards is valid
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards): You must have at least one pair of cards")

        // x...value ==> range from x to end-value, including end-value
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card] // copy cards into array
        }

        // TODO: Shuffle the cards
        shuffleCards()
        initialMove = Date()
        
    }
    
    // shuffles cards before placing onto boards
    private func shuffleCards() {
        var shuffledDeck = [Card]() // temp deck
        
        for _ in cards {
            let randomCard = cards.count.arc4random // pick random card
            shuffledDeck.append(cards.remove(at: randomCard)) // append card to temp deck
        }
        
        cards = shuffledDeck // set board to shuffledDeck
        for index in cards.indices {
            cards[index].isFaceUp = false
        }
        print("Shuffled cards!")
    }
    
}
