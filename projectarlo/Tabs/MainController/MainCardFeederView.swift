//
//  MainCardFeederView.swift
//  projectarlo
//
//  Created by Charlie Arcodia on 11/28/22.
//

import Foundation
import UIKit


class MainCardFeederView : UIView {
    
    var counter : Int = 0
    
    var mainController : MainController?
        
    var cardArray : [UIView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = coreWhiteColor
        
    }
    
    ///call me
    func startRotation(cardArray : [UIView]) {
        
        self.cardArray = cardArray
        
        if self.cardArray.isEmpty {
            print("collectionIsEmpty")
            self.handleEmptyDeck()
            return
        }
        
        let _ = cardArray.count
        
        ///we have cards to load now
        for card in cardArray {
            
            switch counter {
                
            case 0: self.addCard(card: card)
                
            case 1: self.addCard(card: card)
                
            default: print("do nothing and pop from stack then rerun")
            }
            
            counter += 1
            
        }
    }
    
    func addCard(card: UIView) {
        
        let frameWidth = self.frame.width
        var preferredWidth = frameWidth / 1.3
        var verticalOffset : CGFloat = 0.0
        
        switch counter {
        case 0: verticalOffset = 20.0
            card.backgroundColor = coreDeepColor
        case 1: verticalOffset = -10.0
            card.backgroundColor = coreLightColor
        default: print("dont need")
        }
        
        card.translatesAutoresizingMaskIntoConstraints = false
        card.layer.cornerRadius = 40
        
        var preferredheight = preferredWidth * 1.1
        
        if preferredheight + 50 >= self.frame.height {
            preferredheight = self.frame.height - 40
            preferredWidth = preferredWidth - 40
            print("I AM IN HERE?")
        }
       
        self.addSubview(card)

        card.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: verticalOffset).isActive = true
        card.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: verticalOffset).isActive = true
        card.widthAnchor.constraint(equalToConstant: preferredWidth).isActive = true
        card.heightAnchor.constraint(equalToConstant: preferredheight).isActive = true
        
    }
    
    @objc func handleEmptyDeck() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
