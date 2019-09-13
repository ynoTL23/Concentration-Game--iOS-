//
//  Card.swift
//  Concentration
//
//  Created by ynoTL on 9/5/19.
//

import Foundation

// structs have no inheritance compared to classes
// structs are value types, classes are reference types

// value types copy values and only change original values when modified
// reference types are like any other, passing references to a point
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

    // init() tend to have the same internal and external param names
    init() {
        self.identifier = Card.getUniqueIdentifier()
        // self refers to the class's var
    }
    
}
