//
//  GameViewControllerTests.swift
//  BlackJack-52deckTests
//
//  Created by Emil Vaklinov on 04/03/2021.
//

import XCTest
@testable import BlackJack_52deck

class GameViewControllerTests: XCTestCase {

    let vcToTest = GameViewController()
    let mockViewModel = MockViewModel()
    var addFuncCallback: ((Deck)->())? = nil
    var removeAllCardsCallback: (()->())? = nil
    
    func add(card: Deck) {
        addFuncCallback?(card)
    }
    
    func removeAllCards() {
        removeAllCardsCallback?()
    }

    override func setUp() {
       super.setUp()
        
    }
    override func tearDown() {
        super.tearDown()

    }
    
    
    class MockViewModel: GameViewController {
//        var playerCardsSum = 0
//        let newCard : String = drawCard()
//        let newCardValue : Int = getValueOfCard(cardName: newCard)
//
//        override func viewDidLoad() { }
//
//        var hit: (()->())?
//        var stay: (()->())?
//
//        func hitButtonPress() {
//            hit(cardCountLabel.text = String(format:"Score: %i", playerCardsSum))
//        }
//
//        func standButtonPress() {
//            stay?()
//        }
    }
//
    func testHitButtonPress() {
//        let testHitButtonPressExpectation = expectation(description: "testHitButtonPressExpectation")
//        mockViewModel.hit = {
//            testHitButtonPressExpectation.fulfill()
//        }
//
//        vcToTest.hit(UIView())
//
//        waitForExpectations(timeout: 5, handler: nil)
    }
//
    func testStayButtonPress() {
//        let testStandButtonPressExpectation = expectation(description: "testStandButtonPressExpectation")
//        mockViewModel.stay = {
//            testStandButtonPressExpectation.fulfill()
//        }
//
//        vcToTest.stay(UIView())
//
//        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testCardGame() {
        let giveFuncExpectation = expectation(description: "giveFuncExpectation")
        let resetFuncExpectation = expectation(description: "resetFuncExpectation")
        let cardToSend = vcToTest.dealerCard1
        addFuncCallback = { card in
        giveFuncExpectation.fulfill()
            XCTAssert(card as? NSObject == cardToSend)
        }
        removeAllCardsCallback = {
        resetFuncExpectation.fulfill()
        }
        
        // Test by playing check the interaction and integration
        XCTAssert((cardToSend != nil) == false)
        
        waitForExpectations(timeout: 15)
    }
}
