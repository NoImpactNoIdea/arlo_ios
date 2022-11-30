//
//  PostController.swift
//  projectarlo
//
//  Created by Charlie Arcodia on 11/29/22.
//

import Foundation
import UIKit
import Lottie
import Photos
import AVFoundation
import PhotosUI

class PostController : UIViewController {
    
    var counter : CGFloat = 0.0
    
    var cardArray : [UIView] = []
    
    var cardContainer : UIView = {
        
        let cc = UIView()
        cc.translatesAutoresizingMaskIntoConstraints = false
        cc.backgroundColor = coreWhiteColor
        
       return cc
    }()
    
    lazy var recordButton : UIButton = {
        
        let sii = UIButton(type: .system)
        sii.translatesAutoresizingMaskIntoConstraints = false
        sii.contentMode = .scaleAspectFit
        sii.isUserInteractionEnabled = true
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .light)
        let image = UIImage(systemName: "mic", withConfiguration: config)
        sii.setImage(image, for: UIControl.State.normal)
        sii.tintColor = coreWhiteColor
        sii.translatesAutoresizingMaskIntoConstraints = false
        sii.isUserInteractionEnabled = true
        sii.imageView?.contentMode = .scaleAspectFit
        sii.backgroundColor = coreAccentColor
//        sii.addTarget(self, action: #selector(self.handleColorCheckMark), for: UIControl.Event.touchUpInside)
        
        return sii
        
    }()
    
    lazy var photosButton : UIButton = {
        
        let sii = UIButton(type: .system)
        sii.translatesAutoresizingMaskIntoConstraints = false
        sii.contentMode = .scaleAspectFit
        sii.isUserInteractionEnabled = true
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .light)
        let image = UIImage(systemName: "camera", withConfiguration: config)
        sii.setImage(image, for: UIControl.State.normal)
        sii.tintColor = coreWhiteColor
        sii.translatesAutoresizingMaskIntoConstraints = false
        sii.isUserInteractionEnabled = true
        sii.imageView?.contentMode = .scaleAspectFit
        sii.backgroundColor = coreMediumColor
        sii.addTarget(self, action: #selector(self.checkForGalleryAuth), for: UIControl.Event.touchUpInside)
        
        return sii
        
    }()
    
    lazy var submitButton : UIButton = {
        
        let sii = UIButton(type: .system)
        sii.translatesAutoresizingMaskIntoConstraints = false
        sii.contentMode = .scaleAspectFit
        sii.isUserInteractionEnabled = true
        sii.setTitle("Hold to submit", for: .normal)
        sii.titleLabel?.font = UIFont(name: ralewaySemiBold, size: 18)
        sii.tintColor = coreWhiteColor
        sii.translatesAutoresizingMaskIntoConstraints = false
        sii.isUserInteractionEnabled = true
        sii.imageView?.contentMode = .scaleAspectFit
        sii.backgroundColor = coreMediumColor
        sii.isEnabled = false

//        sii.addTarget(self, action: #selector(self.handleColorCheckMark), for: UIControl.Event.touchUpInside)
        
        return sii
        
    }()
    
     let recordAnimator : LottieAnimationView = {
        
        let audioAnimation = LottieAnimationView.init(name: "audio_clip_playing_anim")
        audioAnimation.translatesAutoresizingMaskIntoConstraints = false
        audioAnimation.loopMode = .loop
        audioAnimation.animationSpeed = 1.0
        audioAnimation.backgroundBehavior = .pauseAndRestore
        audioAnimation.contentMode = .scaleToFill
        audioAnimation.backgroundColor = .clear
        audioAnimation.alpha = 0.0
        
        return audioAnimation
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreWhiteColor
        self.addViews()
    }
    
    
    func addViews() {
        
        self.view.addSubview(self.cardContainer)
        self.view.addSubview(self.recordButton)
        self.view.addSubview(self.photosButton)
        self.view.addSubview(self.submitButton)
        self.view.addSubview(self.recordAnimator)

        self.cardContainer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
        self.cardContainer.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.cardContainer.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.cardContainer.heightAnchor.constraint(equalToConstant: self.view.frame.height / 1.5).isActive = true
        
        self.submitButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.submitButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.submitButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.submitButton.heightAnchor.constraint(equalToConstant: 100).isActive = true

        self.photosButton.bottomAnchor.constraint(equalTo: self.submitButton.topAnchor, constant: -20).isActive = true
        self.photosButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.photosButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.photosButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.photosButton.layer.cornerRadius = 25
        
        self.recordButton.bottomAnchor.constraint(equalTo: self.photosButton.topAnchor, constant: -15).isActive = true
        self.recordButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.recordButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.recordButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.recordButton.layer.cornerRadius = 25
        
        self.recordAnimator.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.recordAnimator.rightAnchor.constraint(equalTo: self.recordButton.leftAnchor, constant: -30).isActive = true
        self.recordAnimator.topAnchor.constraint(equalTo: self.recordButton.topAnchor).isActive = true
        self.recordAnimator.bottomAnchor.constraint(equalTo: self.recordButton.bottomAnchor).isActive = true
        
        self.shouldStartRecordingAnimation(shouldStart: true)
        
    }
    
    func shouldStartRecordingAnimation(shouldStart : Bool) {
        if shouldStart {
            self.recordAnimator.alpha = 1.0
            self.recordAnimator.play()
        } else {
            self.recordAnimator.alpha = 0.0
            self.recordAnimator.stop()
        }
    }
    
    var hasViewBeenLaidOut : Bool = false
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if hasViewBeenLaidOut == false {
            
            if self.cardContainer.frame.height != 0.0 {
                
                self.hasViewBeenLaidOut = true
                
                let viewOne = UIView()
                let viewTwo = UIView()
                let cardArray = [viewOne, viewTwo]
                self.startRotation(cardArray: cardArray)
                
            }
        }
    }
    
    ///call me
    func startRotation(cardArray : [UIView]) {
        
        self.cardArray = cardArray
                
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
        
        let frameWidth = self.cardContainer.frame.width
        var preferredWidth = frameWidth / 1.3
        var verticalOffset : CGFloat = 0.0
        
        switch counter {
        case 0: verticalOffset = 20.0
            card.backgroundColor = coreDeepColor
        case 1: verticalOffset = -10.0
            card.backgroundColor = coreAccentColor
        default: print("dont need")
        }
        
        card.translatesAutoresizingMaskIntoConstraints = false
        card.layer.cornerRadius = 40
        card.layer.masksToBounds = true
        card.clipsToBounds = true
       
        
        var preferredheight = preferredWidth * 1.3
        
        if preferredheight + 50 >= self.cardContainer.frame.height {
            preferredheight = self.cardContainer.frame.height - 50
            preferredWidth = preferredWidth - 50
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
        self.view.addSubview(cardShadowView)

        self.view.addSubview(card)

        card.centerYAnchor.constraint(equalTo: self.cardContainer.centerYAnchor, constant: verticalOffset).isActive = true
        card.centerXAnchor.constraint(equalTo: self.cardContainer.centerXAnchor, constant: verticalOffset).isActive = true
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
            
            
            imageViewPerson.image = UIImage(named: "dummy_image")?.withRenderingMode(.alwaysOriginal)

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
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor, view : UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = self.view.bounds

        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func handleMultipleImageUploader() {
        
        DispatchQueue.main.async {
            
            let photoController = PhotoPickerController()
            photoController.postController = self
            
            let nav = UINavigationController(rootViewController: photoController)
            nav.modalPresentationStyle = .popover
            nav.navigationBar.isHidden = true
            self.present(nav, animated: true)
            
        }
    }
}

extension PostController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func checkForGalleryAuth() {
        
        UIDevice.vibrateLight()
        
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
            
        case .authorized:
            self.handleMultipleImageUploader()
            
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                
                if newStatus ==  PHAuthorizationStatus.authorized {
                    self.handleMultipleImageUploader()
                    
                }
            })
            
        default :  print("default")
            AlertControllerCompletion.handleAlertWithCompletion(title: "PERMISSIONS", message: "Please allow Photo Library Permissions in the Settings application.") { isFinished in
                ///all other routes need to enable permissions in the settings
            }
        }
    }
    
    func openGallery() {
        
        DispatchQueue.main.async {
            
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            
            if let topViewController = UIApplication.getTopMostViewController() {
                topViewController.present(imagePicker, animated: true, completion: nil)
            }
        }
    }
}
