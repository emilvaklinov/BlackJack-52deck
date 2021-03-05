//
//  GameViewController.swift
//  BlackJack-52deck
//
//  Created by Emil Vaklinov on 04/03/2021.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var dealerCard1: UIImageView!
    @IBOutlet weak var dealerCard2: UIImageView!
    
    @IBOutlet weak var playerCard1: UIImageView!
    @IBOutlet weak var playerCard2: UIImageView!
    
    @IBOutlet weak var cardCountLabel: UILabel!
    @IBOutlet weak var winsCountLabel: UILabel!
    
//     MARK: - Properties
    var winCount : Int = 0;
    
    var newCardPosition       : CGFloat = 15
    var newDealerCardPosition : CGFloat = 15
    
    var extraCardsArray = [UIImageView]()
    
    var currentDealerHandValues = [Int]()
    var currentPlayerHandValues = [Int]()
    
    var hiddenDealerCardName : String = ""
    
    var cardCount : Int = 52
    
    var cardsArray = Deck()
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
//    MARK: - Init
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        resetGame()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        resetGame()
        
        dealerCard1.image = UIImage(named: "back_blue")
        dealerCard2.image = UIImage(named: "back_blue")

        playerCard1.image = UIImage(named: "back_red")
        playerCard2.image = UIImage(named: "back_red")

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//     MARK: - Logic
    func getValueOfCard(cardName : String) -> Int {
        
        var value = 0
        
        if (cardName.hasPrefix("ace")) {
            value = 1
        }
        
        else if (cardName.hasPrefix("2")) {
            value = 2
        }
        
        else if (cardName.hasPrefix("3")) {
            value = 3
        }
        
        else if (cardName.hasPrefix("4")) {
            value = 4
        }
        
        else if (cardName.hasPrefix("5")) {
            value = 5
        }
        
        else if (cardName.hasPrefix("6")) {
            value = 6
        }
        
        else if (cardName.hasPrefix("7")) {
            value = 7
        }
        
        else if (cardName.hasPrefix("8")) {
            value = 8
        }
        
        else if (cardName.hasPrefix("9")) {
            value = 9
        }
        
        else if (cardName.hasPrefix("10") || cardName.hasPrefix("jack") || cardName.hasPrefix("king") || cardName.hasPrefix("queen")) {
            
            value = 10
        }
        
        return value
        
    }
    
    func drawCard() -> String {
        
        let randNum  : Int = Int(arc4random_uniform(52))
        
        let cardName : String = Deck().cardsArray[randNum] 
        
        //remove card used
        Deck().cardsArray.remove(at: randNum)
        
        cardCount -= 1
        
        return cardName
    }
    
    func resetGame() {
        
        for imageView in extraCardsArray {
            imageView.removeFromSuperview()
        }
        
        newCardPosition = 20
        newDealerCardPosition = 20
        
        if (cardCount <= 0) {
            
            cardsArray = Deck()
            cardCount = 52
            
        }
        
        
        
        let firstDealerCardName = drawCard()
        let firstPlayerCardName = drawCard()
        
        let secondDealerCardName = drawCard()
        hiddenDealerCardName = secondDealerCardName
        
        let secondPlayerCardName = drawCard()
        
        //Update dealer card values array
        
        let dealerCard1Value = getValueOfCard(cardName: firstDealerCardName)
        let dealerCard2Value = getValueOfCard(cardName: secondDealerCardName)
        
        currentDealerHandValues = [dealerCard1Value, dealerCard2Value]
        
        //Update player card values array
        
        let playerCard1Value = getValueOfCard(cardName: firstPlayerCardName)
        let playerCard2Value = getValueOfCard(cardName: secondPlayerCardName)
        
        currentPlayerHandValues = [playerCard1Value, playerCard2Value]
        
        //Animate first dealer card
        UIView.transition(with: self.dealerCard1, duration: 1.0, options: .transitionFlipFromBottom, animations: {
            
            self.dealerCard1.image = UIImage(named: firstDealerCardName)
            
        }, completion:nil)
        
        
        //Animate first player card (with 1/3 delay)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            
            UIView.transition(with: self.playerCard1, duration: 1.0, options: .transitionFlipFromTop, animations: {
                
                self.playerCard1.image = UIImage(named: firstPlayerCardName)
                
            }, completion:nil)
            
        })
        
        //Animate second dealer card (upside down) (with 2/3 delay)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
            
            UIView.transition(with: self.dealerCard2, duration: 1.0, options: .transitionFlipFromBottom, animations: {
                
                self.dealerCard2.image = UIImage(named: "back_blue")
                
            }, completion:nil)
            
        })
        
        
        
        //Animate second player card (upside down) (with one second delay)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            
            UIView.transition(with: self.playerCard2, duration: 1.0, options: .transitionFlipFromTop, animations: {
                
                self.playerCard2.image = UIImage(named: secondPlayerCardName)
                
                
            }, completion:nil)
            
        })
        
        //Update score count after card images are updated (1.4 seconds)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4, execute: {
            
            var card1 = self.currentPlayerHandValues[0]
            var card2 = self.currentPlayerHandValues[1]
            
            //If either card is 1 and the other is 10, card with value 1 is actually 11, win
            if (card2 == 1 && card1 == 10) {
                card2 = 11
            }
            if (card1 == 1 && card2 == 10) {
                card1 = 11
            }
            
            let playerCardsSum : Int = card1 + card2
            
            if (playerCardsSum == 21) {
                self.recordWin(score: playerCardsSum)
            }
            
            self.cardCountLabel.text = String(format:"Score: %i", playerCardsSum)
            
            
        })
        
        
    }
    
    func recordWin(score : Int) {
        
        let alert = UIAlertController(title: "You Win!", message: String(format:"You got a score of %i", score) , preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { action in
            
            self.resetGame()
            
        }))
        
        //Increase win count here
        winCount += 1
        self.winsCountLabel.text = String(format:"Wins: %i", winCount)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func recordLoss(score : Int) {
        
        //flipHiddenCard()
        
        let alert = UIAlertController(title: "You Lose!", message: String(format:"You got a score of %i", score) , preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { action in
            
            
            self.resetGame()
            
        }))
        
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func flipHiddenCard() {
        UIView.transition(with: self.dealerCard2, duration: 1.0, options: .transitionFlipFromTop, animations: {
            
            self.dealerCard2.image = UIImage(named: self.hiddenDealerCardName)
            
        }, completion:nil)
    }
    
    
    @IBAction func hit(_ sender: Any) {
        
        let newCard : String = drawCard()
        let newCardValue : Int = getValueOfCard(cardName: newCard)
        
        currentPlayerHandValues.append(newCardValue)
        
        var playerCardsSum = 0
        
        for cardValue in currentPlayerHandValues {
            playerCardsSum += cardValue
        }
        
        self.cardCountLabel.text = String(format:"Score: %i", playerCardsSum)
        
        if (playerCardsSum > 21) {
            recordLoss(score: playerCardsSum)
            flipHiddenCard()
        }
        
        let oldCard : UIImageView = UIImageView()
        
        oldCard.image = playerCard2.image
        oldCard.frame = playerCard2.frame
        self.view.addSubview(oldCard)
        
        UIView.transition(with: self.view, duration: 1.0, options: .curveEaseInOut, animations: {
            
            oldCard.frame = CGRect(x: self.playerCard1.frame.origin.x + self.newCardPosition , y: self.playerCard1.frame.origin.y, width: self.playerCard1.frame.width, height: self.playerCard1.frame.height)
            
            self.newCardPosition += 15
            
            self.playerCard2.image = UIImage(named: newCard)
            
        })
        
        
        
        extraCardsArray.append(oldCard)
        
        
        
    }
    
    @IBAction func stay(_ sender: Any) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            
            self.flipHiddenCard()
            
        })
        
        
        var dealerCard1Value = self.currentDealerHandValues[0]
        var dealerCard2Value = self.currentDealerHandValues[1]
        
        //If either card is 1 and the other is 10, card with value 1 is actually 11, win
        if (dealerCard2Value == 1 && dealerCard1Value == 10) {
            dealerCard2Value = 11
        }
        if (dealerCard1Value == 1 && dealerCard2Value == 10) {
            dealerCard1Value = 11
        }
        
        var dealerCardSum = dealerCard1Value + dealerCard2Value
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3, execute: {
            
            
            while (dealerCardSum < 15) {
                let newCard : String = self.drawCard()
                let newCardValue : Int = self.getValueOfCard(cardName: newCard)
                
                self.currentDealerHandValues.append(newCardValue)
                
                dealerCardSum = 0
                
                for cardValue in self.currentDealerHandValues {
                    dealerCardSum += cardValue
                }
                
                let oldCard : UIImageView = UIImageView()
                
                oldCard.image = self.dealerCard2.image
                
                oldCard.frame = self.dealerCard2.frame
                
                self.view.addSubview(oldCard)
                
                
                UIView.transition(with: self.view, duration: 1.0, options: .curveEaseInOut, animations: {
                    
                    oldCard.frame = CGRect(x: self.dealerCard1.frame.origin.x + self.newDealerCardPosition , y: self.dealerCard1.frame.origin.y, width: self.dealerCard1.frame.width, height: self.dealerCard1.frame.height)
                    
                    self.newDealerCardPosition += 20
                    
                    self.dealerCard2.image = UIImage(named: newCard)
                    
                    
                })
                
                
                self.extraCardsArray.append(oldCard)
                
                
            }
            
        })
        
        
        var playerCardsSum = 0
        
        for cardValue in currentPlayerHandValues {
            playerCardsSum += cardValue
        }
        
        if (dealerCardSum > 21) {
            recordWin(score: playerCardsSum)
            return;
        }
        
        if (dealerCardSum > playerCardsSum){
            recordLoss(score: playerCardsSum)
            return;
        }
        if (dealerCardSum == playerCardsSum){
            recordLoss(score: playerCardsSum)
            return;
            
        }
        else{
            recordWin(score: playerCardsSum)
        }
        
    }
}
