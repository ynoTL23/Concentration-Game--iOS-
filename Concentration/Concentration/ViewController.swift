//
//  ViewController.swift
//  Concentration
//
//  Created by ynoTL on 9/5/19.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    // game var is only used by VC, set to pvt
    
    private var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet weak var finalScoreLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private var newGameButton: UIButton!
    
    // detect if card was touched
    @IBAction private func touchedCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            flipCountLabel.text = "Flips: \(game.flipCount)"
            updateViewFromModel()
        } else {
            print("Chosen card not found in cardButtons")
        }
    }
    
    // end game screen button
    @IBAction func newGameButtonTouched(_ sender: UIButton) {
        print("New game ... ")
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        emojiChoices = setTheme()

        // set the board, new them/emoji
        updateCardFaces()

        // reset card status
        for var card in game.cards {
            card.isMatched = false
            card.isFaceUp = false
        }

        // show the cards
        for button in cardButtons {
            button.isHidden = false
            button.isEnabled = true
        }
        
        // Hide the end game screen
        finalScoreLabel.isHidden = true
        finalScoreLabel.isEnabled = false
        sender.isHidden = true
        sender.isEnabled = false
        flipCountLabel.text = "Flips: \(game.flipCount)"
        flipCountLabel.isHidden = false
        flipCountLabel.isEnabled = true
    }
    
    // update the board
    private func updateViewFromModel() {
        updateCardFaces()
        
        // check if all cards have been found and matched
        var matched: Int = 0
        for card in game.cards {
            if card.isMatched == true { // is card matched?
                matched += 1
                
                if matched >= game.cards.count { // game has been won if all cards found
                    print("All cards have been found!")
                    print("Game ended!")

                    // clear the board
                    for button in cardButtons {
                        button.isHidden = true
                        button.isEnabled = false
                    }
                    
                    // show end game screen
                    finalScoreLabel.text = "Final Score: \(game.playerScore)"
                    finalScoreLabel.isHidden = false
                    finalScoreLabel.isEnabled = true
                    newGameButton.isHidden = false
                    newGameButton.isEnabled = true
                    flipCountLabel.isHidden = true
                    flipCountLabel.isEnabled = false
                    
                }
            } else { // there is still some cards left
                break
            }
        }
    }
    
    // cards get updated with their right emoji, color, etc.
    func updateCardFaces() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 01, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    // Theme picked
    private func setTheme() -> [String] {
        var themes = [
            "Halloween":      ["👻", "🎃", "☠️", "😈", "🙀", "🍬", "🍫", "🍭"],
            "Christmas":      ["🎁", "🎅🏻", "🎄", "🦌", "🥛", "🍪", "❄️", "⛄️"],
            "Transportation": ["🚒", "🚲", "✈️", "🚁", "⛵️", "🚀", "🚑", "🚂"],
            "Food":           ["🍿", "🌮", "🍔", "🌭", "🍟", "🍕", "🍇", "🍗"],
            "Sports":         ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🎱", "🏓"],
            "Country Flags":  ["🇺🇸", "🇬🇧", "🇨🇦", "🇦🇺", "🇲🇽", "🇩🇪", "🇰🇷", "🇮🇳"]
        ]
        
        let index = themes.count.arc4random // select random index from [themes] dict
        return Array(themes.values)[index] // return the list/array of emojis
    }
    
    lazy private var emojiChoices = setTheme() // set and use theme for game

    private var emoji = [Int: String]()

    private func emoji(for card: Card) -> String {
        // if emoji not set and we have emoji choices, put in dict
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            // "arc4random" is associated/extension of Int, emojiChoise.count will return an int
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }

        // returns 'emoji[card.identifier]' BUT if nil, return "?"
        return emoji[card.identifier] ?? "?"
    }

}


// extend Int for arc4random func
extension Int {
    var arc4random: Int {
        // if value > 0, return int
        if (self > 0) {
            return Int(arc4random_uniform(UInt32(self)))
        } else if (self < 0) { // value is negative
            return -Int(arc4random_uniform(UInt32(-self)))
        } else { // value is zero
            return 0
        }
    }
}

