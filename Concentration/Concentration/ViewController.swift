//
//  ViewController.swift
//  Concentration
//
//  Created by ynoTL on 9/5/19.
//

import UIKit

class ViewController: UIViewController {

    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
            print("Flips: \(flipCount)")
        }
    }
    
    // var cardbuttons: Array<UIButton>
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    var emojiChoices = ["👻", "🎃", "☠️", "😈"]
    
    @IBAction func touchedCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            print("cardNumber: \(cardNumber)")
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
            flipCount += 1
        } else {
            print("Chosen card not found in cardButtons")
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

