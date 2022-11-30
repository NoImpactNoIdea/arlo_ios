//
//  PhotoCollectionCell.swift
//  projectarlo
//
//  Created by Charlie Arcodia on 11/29/22.
//

import Foundation
import Lottie
import UIKit

final class PhotoCollectionCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    var photoCollectionSubview: PhotoCollectionSubview?

    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .clear
        iv.contentMode = .scaleAspectFill
        iv.isUserInteractionEnabled = true
        iv.clipsToBounds = true
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 10
        return iv
    }()
    
    let timeLabel: UILabel = {
        let tl = UILabel()
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.backgroundColor = .clear
        tl.text = "0:0"
        tl.textColor = coreWhiteColor
        tl.font = UIFont(name: ralewayRegular, size: 13)
        tl.numberOfLines = 1
        tl.adjustsFontSizeToFitWidth = true
        tl.textAlignment = .right
        tl.isUserInteractionEnabled = false
        return tl
    }()
    
    var timeShadow: UIView = {
        let ts = UIView()
        ts.translatesAutoresizingMaskIntoConstraints = false
        ts.backgroundColor = coreBlackColor.withAlphaComponent(0.5)
        ts.isUserInteractionEnabled = false
        ts.isHidden = true
        return ts
    }()
    
    let selectedView: UIButton = {
        
        let ts = UIButton(type: .system)
        ts.translatesAutoresizingMaskIntoConstraints = false
        ts.backgroundColor = UIColor (white: 1.0, alpha: 0.8)
        ts.isUserInteractionEnabled = false
        ts.isHidden = true
        ts.layer.masksToBounds = true
        
        let config = UIImage.SymbolConfiguration(pointSize: 22.5, weight: .light)
        let image = UIImage(systemName: "checkmark.circle", withConfiguration: config)
        ts.setImage(image, for: UIControl.State.normal)
        ts.tintColor = coreAccentColor
        ts.imageView?.contentMode = .scaleAspectFit
        ts.layer.cornerRadius = 10

        return ts
        
    }()
    
    
    lazy var lottiAnimation: LottieAnimationView = {
        let la = LottieAnimationView(name : "cell_loaders")
        la.translatesAutoresizingMaskIntoConstraints = false
        la.loopMode = .loop
        la.currentFrame = 0
        la.contentMode = .scaleAspectFill
        la.isUserInteractionEnabled = false
        la.backgroundBehavior = .pauseAndRestore
        la.backgroundColor = .clear
        la.alpha = 0
        return la
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor .clear
        self.addViews()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleCellTap(sender:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    private func addViews() {
        
        self.addSubview(self.imageView)
        self.addSubview(self.selectedView)
        self.addSubview(self.timeShadow)
        self.addSubview(self.timeLabel)
        self.addSubview(self.lottiAnimation)
        
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        self.imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
        self.selectedView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.selectedView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.selectedView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.selectedView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        self.timeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        self.timeLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        self.timeLabel.sizeToFit()
        
        self.timeShadow.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        self.timeShadow.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        self.timeShadow.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        self.timeShadow.topAnchor.constraint(equalTo: self.timeLabel.topAnchor, constant: -5).isActive = true
        
        self.lottiAnimation.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        self.lottiAnimation.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.lottiAnimation.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.lottiAnimation.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func shouldPlayAnimation(shouldPlay : Bool) {
        
//        if shouldPlay {
//            if !self.lottiAnimation.isAnimationPlaying {
//                self.lottiAnimation.alpha = 1.0
//
//                DispatchQueue.main.async {
//                    self.lottiAnimation.play()
//                }
//            }

//        } else {
//            if self.lottiAnimation.isAnimationPlaying {
//                self.lottiAnimation.alpha = 0.0
//                self.lottiAnimation.pause()
//            }
//         }
  }
    
    @objc func handleCellTap(sender : UITapGestureRecognizer) {
        self.photoCollectionSubview?.handleImageTap(sender : sender)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
