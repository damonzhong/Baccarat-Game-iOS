//
//  ViewController.swift
//
//  Created by Damon Zhong on 12/5/20.
//  Copyright © 2020 Damon Zhong. All rights reserved.
//

import UIKit
import Foundation

extension Array {
    subscript(safe index: Index) -> Element? {
        let isValidIndex = index >= 0 && index < count
        return isValidIndex ? self[index] : nil
    }
}

class BaccaratTableView: UIViewController {
    @IBOutlet weak var Total: UILabel!
    @IBOutlet weak var BankerScore: UILabel!
    @IBOutlet weak var PlayerScore: UILabel!
    @IBOutlet weak var Chip5Image: UIImageView!
    @IBOutlet weak var Chip25Image: UIImageView!
    @IBOutlet weak var Chip100Image: UIImageView!
    @IBOutlet weak var BetPlayerView: UIView!
    @IBOutlet weak var BetTieView: UIView!
    @IBOutlet weak var BetBankerView: UIView!
    @IBOutlet weak var Chip5Label: UIImageView!
    @IBOutlet weak var Chip25Label: UIImageView!
    @IBOutlet weak var Chip100Label: UIImageView!
    @IBOutlet weak var userTotalView: UIView!
    @IBOutlet weak var StartButtonWeak: UIButton!
    @IBOutlet weak var ClearButtonWeak: UIButton!
    
    @IBOutlet weak var pCard1Holder: UILabel!
    @IBOutlet weak var pCard2Holder: UILabel!
    @IBOutlet weak var pCard3Holder: UILabel!
    @IBOutlet weak var bCard1Holder: UILabel!
    @IBOutlet weak var bCard2Holder: UILabel!
    @IBOutlet weak var bCard3Holder: UILabel!
    
    @IBOutlet weak var redBackCard: UIImageView!
    @IBOutlet var Pan5Ges: UIPanGestureRecognizer!
    
    @IBOutlet var Pan25Ges: UIPanGestureRecognizer!
    
    @IBOutlet var Pan100Ges: UIPanGestureRecognizer!
    var dealer = Dealer()
    var playerChips: Int = 1000
    var origin5: CGPoint!
    var origin25: CGPoint!
    var origin100: CGPoint!
    var imageTester: UIImageView!
    var image: UIImage!
    var cardBack: UIImageView!
    var pCard1View: UIImageView!
    var pCard2View: UIImageView!
    var pCard3View: UIImageView!
    var bCard1View: UIImageView!
    var bCard2View: UIImageView!
    var bCard3View: UIImageView!
        
    func removeSubview(tag: Int){
        if let viewWithTag = self.view.viewWithTag(tag) {
            viewWithTag.removeFromSuperview()
        }else{
            print("Card to remove not found")
        }
    }
    
    func newGame() {
        
        dealer.startAllowed = false
        //dealer.currentlyPlaying = true
        BankerScore.text = ""
        PlayerScore.text = ""
        dealer.playerCards = []
        dealer.bankerCards = []

        dealer.freshDeck()
        dealer.deck.shuffle()
        
        removeSubview(tag: 11)
        removeSubview(tag: 22)
        removeSubview(tag: 33)
        removeSubview(tag: 44)
        removeSubview(tag: 55)
        removeSubview(tag: 66)
        
    }
    
    
    
    
    func startGame() {
        
        dealer.totalSet(setChipTotal: playerChips)
        dealer.currentlyPlaying = true
        StartButtonWeak.isEnabled = false
        while dealer.currentlyPlaying {

            redBackCard.isHidden = false
            //Player card 1
            dealer.playerDrawsCard()
            image = UIImage(named: dealer.playerCards[0].description)!
            pCard1View = UIImageView(image: image)
            paintCard(drawCardView: pCard1View)
            view.addSubview(pCard1View)

            self.pCard1View.tag = 11
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in              self.dealCardsAnimation(cardDealt: self.pCard1View, placeHolder: self.pCard1Holder)
            })
            

            //Bank Card 1
            dealer.bankerDrawsCard()
            image = UIImage(named: dealer.bankerCards[0].description)!
            bCard1View = UIImageView(image: image)
            paintCard(drawCardView: bCard1View)
            view.addSubview(bCard1View)
            bCard1View.tag = 44
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                self.dealCardsAnimation(cardDealt: self.bCard1View, placeHolder: self.bCard1Holder)

            })

            
            //Player card 2
            dealer.playerDrawsCard()
            image = UIImage(named: dealer.playerCards[1].description)!
            pCard2View = UIImageView(image: image)
            paintCard(drawCardView: pCard2View)
            view.addSubview(pCard2View)
            self.pCard2View.tag = 22
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                
                self.dealCardsAnimation(cardDealt: self.pCard2View, placeHolder: self.pCard2Holder)
            })
            
            dealer.bankerDrawsCard()
            
            image = UIImage(named: dealer.bankerCards[1].description)!
            bCard2View = UIImageView(image: image)
            paintCard(drawCardView: bCard2View)
            view.addSubview(bCard2View)
            self.bCard2View.tag = 55
            //self.view.bringSubviewToFront(redBackCard)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                
                self.dealCardsAnimation(cardDealt: self.bCard2View, placeHolder: self.bCard2Holder)
                //self.view.bringSubviewToFront(self.redBackCard)
                self.bCard2View.tag = 55
            })
            
            
            print("this is player: " + dealer.playerCards.map( { $0.description
            }).joined(separator: ", ") + " \(dealer.playerScore)")
            print("this is banker: " + dealer.bankerCards.map( { $0.description//update uiimages here instead of text
            }).joined(separator: ", ") + " \(dealer.bankerScore)\n")
            
            
            dealer.checkDraw()
            if dealer.playerCards.count == 3{
                image = UIImage(named: dealer.playerCards[2].description)!
                pCard3View = UIImageView(image: image)
                paintCard(drawCardView: pCard3View)
                view.addSubview(pCard3View)
                self.pCard3View.tag = 33
                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                    
                    self.dealCardsAnimation(cardDealt: self.pCard3View, placeHolder: self.pCard3Holder)

                })

            }
            if dealer.bankerCards.count == 3 {
                
                
                image = UIImage(named: dealer.bankerCards[2].description)!
                bCard3View = UIImageView(image: image)
                paintCard(drawCardView: bCard3View)
                view.addSubview(bCard3View)
                self.bCard3View.tag = 66
                DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
                    
                    self.dealCardsAnimation(cardDealt: self.bCard3View, placeHolder: self.bCard3Holder)

                })

            }
            self.view.bringSubviewToFront(redBackCard)
            dealer.compareTotal()
            playerChips = dealer.chipsTotal
            Total.text = "\(playerChips)"
            print("player chips: \(playerChips)")
            print("dealer chips: \(dealer.chipsTotal)")

            
        }
        Timer.scheduledTimer(withTimeInterval: 6, repeats: false, block: {_ in
            self.updateScore()
            self.playerChips = self.dealer.chipsTotal
            print("Chips remaining: \(self.playerChips)")
            self.Pan5Ges.isEnabled = true
            self.Pan25Ges.isEnabled = true
            self.Pan100Ges.isEnabled = true
            self.StartButtonWeak.isEnabled = true
            self.redBackCard.isHidden = true
        })

    }

    
    func updateScore(){
        
        BankerScore.text = "\(self.dealer.bankerScore)"
        PlayerScore.text = "\(self.dealer.playerScore)"
    
    }
    
    @IBAction func startClicked(_ sender: Any) {
        if !dealer.currentlyPlaying {
            Pan5Ges.isEnabled = false
            Pan25Ges.isEnabled = false
            Pan100Ges.isEnabled = false
            
            newGame()
            startGame()
        }
        
    }
    
    @IBAction func ClearClicked(_ sender: Any) {
        
        print("clicked clear")
        dealer.clearbets()
        playerChips = dealer.chipsTotal

        Total.text = "\(playerChips)"
        dealer.chipsOnPlayer = 0
        dealer.chipsOnBanker = 0
        dealer.chipsOnTie = 0
        
    }
    
    //
    //
    // pan handlers
    @IBAction func handlePan5(_ sender: UIPanGestureRecognizer) {
        
        
        let chipView = sender.view!
        
        switch sender.state {
        case .began, .changed:
            moveChipView(viewSender: chipView, sender: sender)
        case .ended:
            betPlaced(viewSender: chipView, chipImageView: Chip5Image, betAmount: 5, origin: origin5)
            playerChips = dealer.chipsTotal
            Total.text = "\(playerChips)"
        default:
            break
        }
        
    }
    
    @IBAction func handlePan25(_ sender: UIPanGestureRecognizer) {
        
        
        let chipView = sender.view!
        
        switch sender.state {
        case .began, .changed:
            moveChipView(viewSender: chipView, sender: sender)
        case .ended:
            betPlaced(viewSender: chipView, chipImageView: Chip25Image, betAmount: 25, origin: origin25)
            playerChips = dealer.chipsTotal
            Total.text = "\(dealer.chipsTotal)"
        default:
            break
        }
    }
    
    @IBAction func handlePan100(_ sender: UIPanGestureRecognizer) {
        
        
        let chipView = sender.view!
        
        switch sender.state {
        case .began, .changed:
            moveChipView(viewSender: chipView, sender: sender)
        case .ended:
            betPlaced(viewSender: chipView, chipImageView: Chip100Image, betAmount: 100, origin: origin100)
            playerChips = dealer.chipsTotal
            Total.text = "\(dealer.chipsTotal)"
        default:
            break
        }
    }

    // Gestures to place bets on "table"
    func moveChipView(viewSender: UIView, sender: UIPanGestureRecognizer) {
        
        
        let translation = sender.translation(in: view)
        
        viewSender.center = CGPoint(x: viewSender.center.x + translation.x, y: viewSender.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)

    }
 
    
    func betPlaced(viewSender: UIView, chipImageView: UIImageView, betAmount: Int, origin: CGPoint) {
        
        
            if viewSender.frame.intersects(BetPlayerView.frame) {
                chipImageView.frame.origin = origin
                dealer.checkPlayerBets(betAmount: betAmount)
            }
            else if viewSender.frame.intersects(BetBankerView.frame) {
                chipImageView.frame.origin = origin
                dealer.checkBankerBets(betAmount: betAmount)
            }
            else if viewSender.frame.intersects(BetTieView.frame) {
                chipImageView.frame.origin = origin
                dealer.checkTieBets(betAmount: betAmount)
            }
            else {
                UIView.animate(withDuration: 0.1, animations: {
                    chipImageView.frame.origin = origin
                })
                
            }
        
    }
    
    
    func drawBetBorder(betView: UIView) {
        
        
        betView.layer.borderColor = UIColor.white.cgColor
        betView.layer.borderWidth = 2.0
        betView.layer.cornerRadius = 5.0
    }
    
    func drawShadowOnChip(chipView: UIImageView) {
        
        
        chipView.layer.shadowColor = UIColor.black.cgColor
        chipView.layer.shadowOpacity = 0.3
        chipView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        chipView.layer.shadowRadius = 1.0
        chipView.layer.masksToBounds = false
        chipView.layer.cornerRadius = 3.0
          
    }
    
    func drawShadowOnCard(cardView: UIImageView) {
        
        
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.shadowOffset = CGSize(width: 4.0, height: 6.0)
        cardView.layer.shadowRadius = 2.0
        cardView.layer.masksToBounds = false
        cardView.layer.cornerRadius = 3.0
        
    }
    
    func paintCard(drawCardView: UIImageView) {
    
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let cardWidth: CGFloat = 85
        let cardStartWidth = (screenWidth / 2) - (cardWidth / 2)
        
        drawCardView.frame = CGRect(x: cardStartWidth , y: 0, width: cardWidth, height: 130)
        drawShadowOnCard(cardView: drawCardView)
        
    }
    
    func dealCardsAnimation(cardDealt: UIImageView, placeHolder: UILabel) {

        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            cardDealt.transform = CGAffineTransform(translationX: 0, y: 100)
            }) {(_) in
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                    cardDealt.frame.origin = placeHolder.frame.origin
            })
        }
        
        
    }
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"casinoDarkGreen")!)
        
        customButton(button: StartButtonWeak)
        customButton(button: ClearButtonWeak)
        userTotalView.layer.cornerRadius = 2.8
        userTotalView.layer.shadowColor = UIColor.black.cgColor
        userTotalView.layer.shadowOpacity = 0.5
        origin5 = Chip5Image.frame.origin
        origin25 = Chip25Image.frame.origin
        origin100 = Chip100Image.frame.origin
        view.bringSubviewToFront(Chip5Image)
        view.bringSubviewToFront(Chip25Image)
        view.bringSubviewToFront(Chip100Image)
        drawShadowOnChip(chipView: Chip5Label)
        drawShadowOnChip(chipView: Chip25Label)
        drawShadowOnChip(chipView: Chip100Label)
        drawShadowOnChip(chipView: Chip5Image)
        drawShadowOnChip(chipView: Chip25Image)
        drawShadowOnChip(chipView: Chip100Image)
        drawBetBorder(betView: BetPlayerView)
        drawBetBorder(betView: BetTieView)
        drawBetBorder(betView: BetBankerView)
        
        drawShadowOnCard(cardView: redBackCard)
        
        dealer.startAllowed = true
        self.view.bringSubviewToFront(redBackCard)
        redBackCard.isHidden = true

        dealer.totalSet(setChipTotal: playerChips)
        Total.text = "\(playerChips)"
    
    }

    func customButton(button: UIButton) {
        
        
        button.layer.cornerRadius = 12.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
        button.layer.shadowRadius = 1.0
        button.layer.masksToBounds = false
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 3.0
        
    }
    
}//File ends here

