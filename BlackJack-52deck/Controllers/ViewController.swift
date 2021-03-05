//
//  ViewController.swift
//  BlackJack-52deck
//
//  Created by Emil Vaklinov on 04/03/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cardImage: UIImageView!
    
//    MARK: - First view random image display
    private let cardsArray = Deck()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let randNum : Int = Int(arc4random_uniform(52))
        
        cardImage.image = UIImage(named: Deck().cardsArray[randNum])
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startGame(_ sender: Any) {
        
        let goToGameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC")
            as! GameViewController
        
        goToGameVC.modalTransitionStyle = .flipHorizontal
        
        self.present(goToGameVC, animated: true, completion: nil)
        
    }
    
}
