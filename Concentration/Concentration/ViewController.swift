//
//  ViewController.swift
//  Concentration
//
//  Created by ynoTL on 9/5/19.
//

import UIKit

class ViewController: UIViewController {
    
    // allow VC and Concentration to comm with each other
    // Concentration has a free init() when all vars are init'd
    // structs get free init() too but all vars need to re-init'd
    
    // 'lazy' var does not init before something calls for it
    // 'lazy' cannot have didSet{} / property observers
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)

    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!

    // var cardbuttons: Array<UIButton>
    @IBOutlet var cardButtons: [UIButton]!

    
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

    var emojiChoices = ["👻", "🎃", "☠️", "😈", "🍎", "🧟‍♂️", "🍬", "🍫", "🍭"]

    // identifier is an int
    // value is a string
    var emoji: [Int: String]()
    // var emoji: Dictionary<Int, String>()

    func emoji(for card: Card) -> String {
        // Dict returns an Optional ==> String?
        // Dictionary may or may not return a string
        
        // if emoji not set and we have emoji choices, put in dict
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            // gen random num from zero to end-value, exclusive
            // arc4rand only works with unsigned ints (UInt32: is a struct as well)
            // you must convert beforehand
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            // randomIndex will be used as an Int for array, must be converted to Int

            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }

        // returns 'emoji[card.identifier]' but if nil, return "?"
        return emoji[card.identifier] ?? "?"
    }

}

