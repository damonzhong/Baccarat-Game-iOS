//
//  DealerBaccarat.swift
//
//  Created by Damon Zhong on 12/8/20.
//  Copyright © 2020 Damon Zhong. All rights reserved.
//

import Foundation

extension Array where Element == PlayingCard {
    var totalValue0: Int {
        var total = 0
        for card in self {
            total += card.value
        }
        total = total % 10
        return total
    }
}


class Dealer {
    var deck = PlayingCardDeck()
    var playerCards: [PlayingCard] = []
    var bankerCards: [PlayingCard] = []
    var playerCardCount: Int = 0
    var playerCard3 = 0
    var playerScore = 0
    var bankerScore = 0
    var currentlyPlaying = false
    var chipsOnPlayer: Int = 0
    var chipsOnBanker: Int = 0
    var chipsOnTie: Int = 0
    var chipsTotal: Int = 0
    var startAllowed = false
    
    
    func freshDeck() {
        deck = PlayingCardDeck()
    }
    
    func playerDrawsCard() {
        guard let pickedCard = deck.cards.popLast() else {
            return
        }
        playerCards.append(pickedCard)
        playerCardCount += 1
        let total = playerCards.totalValue0
        playerScore = total
      //  print("Player drew: \(playerScore)")
        
    }
    
    func bankerDrawsCard() {
        guard let pickedCard = deck.cards.popLast() else {
            return
        }
        bankerCards.append(pickedCard)
        let total = bankerCards.totalValue0
        bankerScore = total
       // print("Banker drew: \(bankerScore)")
    }

    func checkDraw() {
//        let playerTotal = playerCards.totalValue
//        let bankerTotal = bankerCards.totalValue
        if (playerScore == 8 || bankerScore == 8) || (playerScore == 9 || bankerScore == 9) && playerCardCount < 3 {
            compareTotal()
        }
        else if playerScore == bankerScore {
            checkTie()
        }
        else if (playerScore == 6 || playerScore ==  7) && bankerScore >= 5 {
            compareTotal()
        }
        else if (playerScore == 6 || playerScore ==  7) && bankerScore < 5 {
            bankerDrawsCard()
            compareTotal()
        }
        else if playerScore <= 5 {
            playerDrawsCard()
            if playerCardCount == 3 {
                playerCard3 = playerCards[playerCardCount - 1].type.value
            }
            print("this is player: " + playerCards.map( { $0.description }).joined(separator: ", ") + " \(playerScore)")
            
            switch playerCard3 {
            case 9:
                if (bankerScore == 3) || (bankerScore == 2) || (bankerScore == 1) || (bankerScore == 0) {
                    bankerDrawsCard()
                    print("this is banker: " + bankerCards.map( { $0.description }).joined(separator: ", ") + " \(bankerScore)")
                }
            case 8:
                if (bankerScore == 2) || (bankerScore == 1) || (bankerScore == 0) {
                    bankerDrawsCard()
                    print("this is banker: " + bankerCards.map( { $0.description }).joined(separator: ", ") + " \(bankerScore)")
                }
            case 7,6:
                if (bankerScore == 6) || (bankerScore == 5) || (bankerScore == 4) || (bankerScore == 3) || (bankerScore == 2) || (bankerScore == 1) || (bankerScore == 0)  {
                    bankerDrawsCard()
                    print("this is banker: " + bankerCards.map( { $0.description }).joined(separator: ", ") + " \(bankerScore)")
                }
            case 5,4:
                if (bankerScore == 5) || (bankerScore == 4) || (bankerScore == 3) || (bankerScore == 2) || (bankerScore == 1) || (bankerScore == 0)  {
                    bankerDrawsCard()
                    print("this is banker: " + bankerCards.map( { $0.description }).joined(separator: ", ") + " \(bankerScore)")
                }
            case 3,2:
                if (bankerScore == 4) || (bankerScore == 3) || (bankerScore == 2) || (bankerScore == 1) || (bankerScore == 0) {
                    bankerDrawsCard()
                    print("this is banker: " + bankerCards.map( { $0.description }).joined(separator: ", ") + " \(bankerScore)")

                }
            case 10,1,0:
                if (bankerScore == 3) || (bankerScore == 2) || (bankerScore == 1) || (bankerScore == 0) {
                    bankerDrawsCard()
                    print("this is banker: " + bankerCards.map( { $0.description }).joined(separator: ", ") + " \(bankerScore)")
                }
            default:
                print("Error")
            }
        }
    }
    
    
    func checkTie() {
        
        
        if playerScore < 5 && playerCard3 < 3 {
            playerDrawsCard()
            checkDraw()
        }
        else {
            compareTotal()
        }
    }
    
    func compareTotal() {
        
        
        if playerScore == bankerScore {
            cashOut(outcome: "Tie")
            print("Tie")
        }
        else if playerScore > bankerScore {
            cashOut(outcome: "PlayerWin")
            print("Player won\n")
        }
        else if bankerScore > playerScore {
            cashOut(outcome: "BankerWin")
            print("Banker won\n")
        }
        
    }
    
    func cashOut(outcome: String) {
        
        
        switch outcome {
        case "Tie":
            currentlyPlaying = false
            chipsTotal += (chipsOnPlayer + chipsOnBanker)
            chipsTotal += (2 * chipsOnTie)
        case "PlayerWin":
            currentlyPlaying = false
            chipsTotal += (2 * chipsOnPlayer)
        case "BankerWin":
            currentlyPlaying = false
            chipsTotal += (2 * chipsOnBanker)
        default:
            break
        }
        
        chipsOnPlayer = 0
        chipsOnBanker = 0
        chipsOnTie = 0
        playerCards = []
        bankerCards = []

    }
    

    func totalSet(setChipTotal: Int) {
        
        chipsTotal = setChipTotal
        
    }
    
    func clearbets() {
        
        chipsTotal += (chipsOnPlayer + chipsOnBanker + chipsOnTie)
        
    }
    
    func checkPlayerBets(betAmount: Int) {
        
        
        switch betAmount {
        case 100:
            chipsOnPlayer += 100
            chipsTotal -= 100
        case 25:
            chipsOnPlayer += 25
            chipsTotal -= 25
        case 5:
            chipsOnPlayer += 5
            chipsTotal -= 5
        default:
            break
        }
    }
    
    func checkBankerBets(betAmount: Int) {
        
        
        switch betAmount {
        case 100:
            chipsOnBanker += 100
            chipsTotal -= 100
        case 25:
            chipsOnBanker += 25
            chipsTotal -= 25
        case 5:
            chipsOnBanker += 5
            chipsTotal -= 5
        default:
            break
        }
        
    }
    
    func checkTieBets(betAmount: Int) {
        
        
        switch betAmount {
        case 100:
            chipsOnTie += 100
            chipsTotal -= 100
        case 25:
            chipsOnTie += 25
            chipsTotal -= 25
        case 5:
            chipsOnTie += 5
            chipsTotal -= 5
        default:
            break
        }
    }
}
