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
struct Card : Hashable {
    
    var isFaceUp = false
    internal var isMatched = false
    private var identifier: Int

    private static var identifierFactory = 0

    // return an identifier as int
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    // hashable
    var hashValue : Int {
        return self.identifier
    }
    
    // equatable
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return (lhs.identifier == rhs.identifier)
    }

    // init() tend to have the same internal and external param names
    init() {
        self.identifier = Card.getUniqueIdentifier()
        // self refers to the class's var
    }
    
}
