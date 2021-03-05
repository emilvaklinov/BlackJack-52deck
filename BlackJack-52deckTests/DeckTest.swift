//
//  DeckTest.swift
//  BlackJack-52deckTests
//
//  Created by Emil Vaklinov on 04/03/2021.
//

import XCTest
@testable import BlackJack_52deck

class DeckTest: XCTestCase {

    let allPossibleCards = Deck().cardsArray.count
    var randNum  : Int = Int(arc4random_uniform(52))
    
    
    override func setUp() {
       super.setUp()
        
    }
    override func tearDown() {
        super.tearDown()

    }

    // Passing when the deck has 52 cars
    func testHave52CardsInDeck() {
        
        XCTAssertTrue(allPossibleCards == 52)
        

    }
    
    // Falling when the deck has not 52 cards
    func testHaveLessThan52CardsInDeck() {
        
//        XCTAssertTrue(allPossibleCards < 52, "The deck is not 52 cards")

    }
    
    func testRandomCard() {
        XCTAssertTrue(randNum == randNum)
//        XCTAssertTrue(randNum == 52)
    }
}
