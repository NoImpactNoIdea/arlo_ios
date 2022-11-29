//
//  MainCardFeederView.swift
//  projectarlo
//
//  Created by Charlie Arcodia on 11/28/22.
//

import Foundation
import UIKit
import Lottie

class MainCardFeederView : UIView {
    
    var counter : Int = 0
    
    var mainController : MainController?
        
    var cardArray : [UIView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        
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
        card.layer.masksToBounds = true
        card.clipsToBounds = true
       
        
        var preferredheight = preferredWidth * 1.1
        
        if preferredheight + 50 >= self.frame.height {
            preferredheight = self.frame.height - 40
            preferredWidth = preferredWidth - 40
            print("I AM IN HERE?")
        }
        
        let cardShadowView = UIView()
        cardShadowView.translatesAutoresizingMaskIntoConstraints = false
        cardShadowView.backgroundColor = coreWhiteColor
        cardShadowView.clipsToBounds = false
        cardShadowView.layer.masksToBounds = false
        cardShadowView.layer.shadowColor = coreBlackColor.withAlphaComponent(1.0).cgColor
        cardShadowView.layer.shadowOpacity = 0.25
        cardShadowView.layer.shadowOffset = CGSize(width: 0, height: 10)
        cardShadowView.layer.shadowRadius = 8
        cardShadowView.layer.shouldRasterize = false
        cardShadowView.layer.cornerRadius = 40
        self.addSubview(cardShadowView)

        self.addSubview(card)

        card.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: verticalOffset).isActive = true
        card.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: verticalOffset).isActive = true
        card.widthAnchor.constraint(equalToConstant: preferredWidth).isActive = true
        card.heightAnchor.constraint(equalToConstant: preferredheight).isActive = true
        
        cardShadowView.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -3).isActive = true
        cardShadowView.leftAnchor.constraint(equalTo: card.leftAnchor, constant: 3).isActive = true
        cardShadowView.rightAnchor.constraint(equalTo: card.rightAnchor, constant: -3).isActive = true
        cardShadowView.topAnchor.constraint(equalTo: card.topAnchor, constant: 3).isActive = true

        let imageViewPerson : UIImageView = UIImageView()
        imageViewPerson.contentMode = .scaleAspectFill
        imageViewPerson.backgroundColor = .clear
        imageViewPerson.translatesAutoresizingMaskIntoConstraints = false
        imageViewPerson.clipsToBounds = true
        
        card.addSubview(imageViewPerson)
        imageViewPerson.bottomAnchor.constraint(equalTo: card.bottomAnchor).isActive = true
        imageViewPerson.leftAnchor.constraint(equalTo: card.leftAnchor).isActive = true
        imageViewPerson.rightAnchor.constraint(equalTo: card.rightAnchor).isActive = true
        imageViewPerson.topAnchor.constraint(equalTo: card.topAnchor).isActive = true
        
        
        let bottomContainer = UIView()
        bottomContainer.backgroundColor = .clear
        bottomContainer.translatesAutoresizingMaskIntoConstraints = false
        
        card.addSubview(bottomContainer)
        bottomContainer.bottomAnchor.constraint(equalTo: card.bottomAnchor).isActive = true
        bottomContainer.leftAnchor.constraint(equalTo: card.leftAnchor).isActive = true
        bottomContainer.rightAnchor.constraint(equalTo: card.rightAnchor).isActive = true
        bottomContainer.topAnchor.constraint(equalTo: card.centerYAnchor, constant: 20).isActive = true
        
        let audioAnimation = LottieAnimationView.init(name: "audio_clip_playing_anim")
        audioAnimation.translatesAutoresizingMaskIntoConstraints = false
        audioAnimation.loopMode = .loop
        audioAnimation.animationSpeed = 1.0
        audioAnimation.backgroundBehavior = .pauseAndRestore
        audioAnimation.contentMode = .scaleToFill
        audioAnimation.backgroundColor = .clear
        audioAnimation.alpha = 0.0
        
        bottomContainer.addSubview(audioAnimation)
        audioAnimation.bottomAnchor.constraint(equalTo: bottomContainer.bottomAnchor, constant: -5).isActive = true
        audioAnimation.leftAnchor.constraint(equalTo: bottomContainer.leftAnchor, constant: 20).isActive = true
        audioAnimation.rightAnchor.constraint(equalTo: bottomContainer.rightAnchor, constant: -20).isActive = true
        audioAnimation.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        if counter != 0 {
            imageViewPerson.image = UIImage(named: "dummy_image")?.withRenderingMode(.alwaysOriginal)

            audioAnimation.alpha = 1.0
          
            audioAnimation.play { complete in
               
            }
        } else {
            
            var blurredEffectView = UIVisualEffectView()
            
            let blurEffect = UIBlurEffect(style: .systemChromeMaterialLight)
            blurredEffectView = UIVisualEffectView(effect: blurEffect)
            blurredEffectView.translatesAutoresizingMaskIntoConstraints = false
            blurredEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
           
            card.addSubview(blurredEffectView)

            blurredEffectView.topAnchor.constraint(equalTo: card.topAnchor).isActive = true
            blurredEffectView.leftAnchor.constraint(equalTo: card.leftAnchor).isActive = true
            blurredEffectView.rightAnchor.constraint(equalTo: card.rightAnchor).isActive = true
            blurredEffectView.bottomAnchor.constraint(equalTo: card.bottomAnchor).isActive = true
            
            
            imageViewPerson.image = UIImage(named: "dummy_image_two")?.withRenderingMode(.alwaysOriginal)

            card.rotate(angle: 2)
            cardShadowView.rotate(angle: 2)
        }
            
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.backgroundColor = .clear
        nameLabel.text = "Wynonna\nRyder"
        nameLabel.textColor = coreWhiteColor
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont(name: ralewaySemiBold, size: 30)
        nameLabel.numberOfLines = 2
        
        let fullMessage = "Wynonna\nRyder"
        nameLabel.colorFontString(text: fullMessage, coloredText: "Ryder", color: coreWhiteColor, fontName: ralewaySemiBold, fontSize: 20)
        
        bottomContainer.addSubview(nameLabel)
        
        nameLabel.bottomAnchor.constraint(equalTo: audioAnimation.topAnchor, constant: -10).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: bottomContainer.leftAnchor, constant: 30).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: bottomContainer.rightAnchor, constant: -30).isActive = true
        nameLabel.sizeToFit()
        
        setGradientBackground(colorTop: UIColor .clear, colorBottom: UIColor .black, view: bottomContainer)
        
    }
    
    @objc func handlePulseAnimation(view : UIView) {
        
        UIView.animate(withDuration: 0.04, delay: 0, options: .curveEaseInOut) {
            
            view.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            
        } completion: { complete in
            
            UIView.animate(withDuration: 0.04, delay: 0, options: .curveEaseInOut) {
                
                view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                
            } completion: { complete in
                UIView.animate(withDuration: 0.04, delay: 0, options: .curveEaseInOut) {
                    
                    view.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                    
                } completion: { complete in
                    
                    UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut) {
                        
                        view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                        
                    } completion: { complete in
                        print("anim is complete")
                    }
                }
            }
        }
    }
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor, view : UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds

        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @objc func handleEmptyDeck() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
