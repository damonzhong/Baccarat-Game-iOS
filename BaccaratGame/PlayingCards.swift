//
//  PlayingCards.swift
//  CSC690FinalProject
//
//  Created by Damon Zhong on 12/5/20.
//  Copyright © 2020 Damon Zhong. All rights reserved.
//

import Foundation

enum Suit: String, CustomStringConvertible, CaseIterable {
    case diamonds = "D"
    case spades = "S"
    case clubs = "C"
    case hearts = "H"
    
    var description: String {
        return self.rawValue
    }
}


enum FaceCard: String, CaseIterable, CustomStringConvertible {
    case jack = "J"
    case queen = "Q"
    case king = "K"
    
    var description: String {
        return self.rawValue
    }
}

enum NumberCard: Int, CaseIterable, CustomStringConvertible {
    case ace = 1
    case two = 2
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    
    var description: String {
        return String(self.rawValue)
    }
}

enum CardType: CustomStringConvertible {
    case number(NumberCard)
    case face(FaceCard)
    
    var description: String {
        switch self {
        case .number(let numberCard):
            return numberCard.description
        case .face(let faceCard):
            return faceCard.description
        }
    }
    
    var value: Int {
        switch self {
        case .number(let numberCard):
            return numberCard.rawValue
        case .face:
            return 10
        }
    }
}

struct PlayingCard {
    let suit: Suit
    let type: CardType
    
    var value: Int {
        return type.value
    }
}

extension PlayingCard: CustomStringConvertible {
    var description: String {
        return "\(type)\(suit)"
    }
}


class PlayingCardDeck: CustomStringConvertible {
    var cards: [PlayingCard] = []
    
    init() {
        for suit in Suit.allCases {
            for numberCard in NumberCard.allCases {
                cards.append(PlayingCard(suit: suit, type: .number(numberCard)))
            }
            for faceCard in FaceCard.allCases {
                cards.append(PlayingCard(suit: suit, type: .face(faceCard)))
            }
        }
    }
    
    var description: String {
        return cards
            .map({ return $0.description })
            .joined(separator: ", ")
    }
    
    func shuffle() {
        cards.shuffle()
    }
}
