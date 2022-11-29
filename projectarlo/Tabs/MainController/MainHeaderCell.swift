//
//  MainPendingMessageContainer.swift
//  projectarlo
//
//  Created by Charlie Arcodia on 11/28/22.
//

import Foundation
import UIKit
import Lottie

class MainHeaderCell : UIView {
    
    var mainController : MainController?
    
    var headerLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.textColor = coreDeepColor
        hfl.textAlignment = .left
        hfl.font = UIFont(name: ralewayLight, size: 40)
        hfl.numberOfLines = 2
        return hfl
    }()
    
    lazy var messagesButton : UIButton = {
        
        let sii = UIButton(type: .system)
        sii.translatesAutoresizingMaskIntoConstraints = false
        sii.contentMode = .scaleAspectFit
        sii.isUserInteractionEnabled = true
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .light)
        let image = UIImage(systemName: "heart.circle.fill", withConfiguration: config)
        sii.setImage(image, for: UIControl.State.normal)
        sii.tintColor = coreDeepColor
        sii.translatesAutoresizingMaskIntoConstraints = false
        sii.isUserInteractionEnabled = true
        sii.imageView?.contentMode = .scaleAspectFit
        sii.backgroundColor = coreUltraLightColor
        sii.addTarget(self, action: #selector(self.handleMessagesButton), for: UIControl.Event.touchUpInside)
        
        return sii
        
    }()
    
    var pulseAnimation : LottieAnimationView = {
        
        let lav = LottieAnimationView.init(name: "purple_pulse")
        lav.translatesAutoresizingMaskIntoConstraints = false
        lav.loopMode = .loop
        lav.animationSpeed = 0.75
        lav.backgroundBehavior = .pauseAndRestore
    
       return lav
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = coreWhiteColor
        self.addViews()
        
        let fullMessage = "Hello,\nCharlie"
        self.headerLabel.colorFontString(text: fullMessage, coloredText: "Charlie", color: coreMediumColor, fontName: ralewaySemiBold, fontSize: 40)
        self.headerLabel.setLineSpacing(lineSpacing: 0.1, lineHeightMultiple: 1.0)
        
        self.callAnimation()
        
    }
    
    func addViews() {
        
        self.addSubview(self.pulseAnimation)
        self.addSubview(self.messagesButton)
        self.addSubview(self.headerLabel)

        self.messagesButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        self.messagesButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        self.messagesButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.messagesButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        self.messagesButton.layer.cornerRadius = 44/2
        
        self.pulseAnimation.centerYAnchor.constraint(equalTo: self.messagesButton.centerYAnchor, constant: 0).isActive = true
        self.pulseAnimation.centerXAnchor.constraint(equalTo: self.messagesButton.centerXAnchor, constant: 0).isActive = true
        self.pulseAnimation.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.pulseAnimation.widthAnchor.constraint(equalToConstant: 70).isActive = true

        self.headerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        self.headerLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        self.headerLabel.rightAnchor.constraint(equalTo: self.messagesButton.leftAnchor, constant: -30).isActive = true
        self.headerLabel.sizeToFit()
        
    }
    
    func callAnimation() {
        self.pulseAnimation.play { complete in
            print("Anim Loop for Messages Button")
        }
    }
    
    @objc func handleMessagesButton() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
