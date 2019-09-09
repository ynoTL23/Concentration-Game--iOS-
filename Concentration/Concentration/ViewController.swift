//
//  ViewController.swift
//  Concentration
//
//  Created by ynoTL on 9/5/19.
//

import UIKit

class ViewController: UIViewController {
    
    // lazy variable: var will get init the first time it gets referenced
    // lazy vars can't have observers, like didSet{}
    lazy var game = Concentration(numberOfPairsOfCards: ((cardButtons.count + 1) / 2))
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    // var cardbuttons: Array<UIButton>
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    var emojiChoices = ["👻", "🎃", "☠️", "😈", "🍎", "🧟‍♂️", "🍬", "🍫", "🍭"]
    
    // Dictionary
    // Int = key, String = data stored/returned
    var emoji = [Int : String]()
    
    func emoji(for card: Card) -> String {
        if let chosenEmoji = emoji[card.identifier] {
            return emoji[card.identifier]!
        } else {
            return "?"
        }
        // return emoji(card.identifier) ?? "?"
        // alt. method
    }
    
    @IBAction func touchedCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card not found in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index] // grab the button
            let card = game.cards[index] // grab the card
            if card.isFaceUp { // if card is face up, turn it back over
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else { // else face down
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        }
    }

}

