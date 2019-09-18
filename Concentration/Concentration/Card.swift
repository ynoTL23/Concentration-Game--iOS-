//
//  Card.swift
//  Concentration
//
//  Created by ynoTL on 9/5/19.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int

    static var identifierFactory = 0

    // return an identifier as int
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }

    init() {
        self.identifier = Card.getUniqueIdentifier()
        // self refers to the class's var
    }
    
}
