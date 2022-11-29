//
//  HorizontalCollectionView.swift
//  projectarlo
//
//  Created by Charlie Arcodia on 11/28/22.
//

import Foundation
import UIKit
import SDWebImage
import Firebase

class SpotLightCollectionView : UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    private let spotlightID = "spotlightID"
    
    var mainController : MainController?
  
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.dataSource = self
        self.delegate = self
        
        self.isPrefetchingEnabled = false
        self.keyboardDismissMode = UIScrollView.KeyboardDismissMode.interactive
        self.alwaysBounceVertical = false
        self.alwaysBounceHorizontal = true
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.allowsMultipleSelection = true
        self.canCancelContentTouches = false
        self.contentInsetAdjustmentBehavior = .never
        self.delaysContentTouches = true
        self.contentInset = UIEdgeInsets(top: 0, left: 21, bottom: 0, right: 0)
        
        self.register(SpotLightFeeder.self, forCellWithReuseIdentifier: self.spotlightID)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.height, height: UIScreen.main.bounds.height / spotlightDivisorHeight)///roughly height
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: self.spotlightID, for: indexPath) as! SpotLightFeeder
        cell.spotLightCollectionView = self
        
        if indexPath.item == 0 {
            cell.addIcon.isHidden = false
        } else {
            cell.addIcon.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SpotLightFeeder : UICollectionViewCell {
    
    var spotLightCollectionView : SpotLightCollectionView?
    
    lazy var containerView : UIButton = {
        
        let cv = UIButton()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = coreWhiteColor
        cv.layer.cornerRadius = 0
        cv.clipsToBounds = true
        
        return cv
    }()
    
    let profileImageView : UIImageView = {
        
        let dcl = UIImageView()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = coreUltraLightColor
        dcl.contentMode = .scaleAspectFill
        dcl.isUserInteractionEnabled = false
        dcl.clipsToBounds = true
        dcl.image = UIImage(named: "dummy_image_two")?.withRenderingMode(.alwaysOriginal)

        return dcl
    }()
    
    lazy var coloredRingView : UIButton = {
        
        let cv = UIButton()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = coreLightColor
        cv.layer.cornerRadius = 0
        cv.clipsToBounds = true
        
        return cv
    }()
    
    var nameLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "Cristina"
        hfl.textColor = coreMediumColor
        hfl.textAlignment = .center
        hfl.font = UIFont(name: ralewaySemiBold, size: 13)
        hfl.clipsToBounds = false
        hfl.layer.masksToBounds = false
        
        return hfl
    }()
    
    var addIcon : UIImageView = {
        
        let sii = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 17, weight: .light)
        let image = UIImage(systemName: "plus.circle.fill", withConfiguration: config)
        sii.image = image
        sii.tintColor = coreAccentColor
        sii.translatesAutoresizingMaskIntoConstraints = false
        sii.backgroundColor = coreWhiteColor
        return sii
    }()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.addViews()
        
    }
    
    func addViews() {
        
        self.addSubview(self.coloredRingView)
        self.addSubview(self.containerView)
        self.containerView.addSubview(self.profileImageView)
        self.addSubview(self.nameLabel)
        self.addSubview(self.addIcon)

        self.containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 3).isActive = true
        self.containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.containerView.heightAnchor.constraint(equalToConstant: self.frame.height - 22).isActive = true
        self.containerView.widthAnchor.constraint(equalToConstant: self.frame.height - 22).isActive = true
        self.containerView.layer.cornerRadius = (self.frame.height - 22) / 2
        
        self.profileImageView.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor, constant: 0).isActive = true
        self.profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.profileImageView.heightAnchor.constraint(equalToConstant: self.frame.height - 26).isActive = true
        self.profileImageView.widthAnchor.constraint(equalToConstant: self.frame.height - 26).isActive = true
        self.profileImageView.layer.cornerRadius = (self.frame.height - 26) / 2

        self.coloredRingView.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor, constant: 0).isActive = true
        self.coloredRingView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.coloredRingView.heightAnchor.constraint(equalToConstant: self.frame.height - 20).isActive = true
        self.coloredRingView.widthAnchor.constraint(equalToConstant: self.frame.height - 20).isActive = true
        self.coloredRingView.layer.cornerRadius = (self.frame.height - 20) / 2
        
        self.nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        self.nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.nameLabel.sizeToFit()
        
        self.addIcon.centerXAnchor.constraint(equalTo: self.coloredRingView.rightAnchor, constant: -10).isActive = true
        self.addIcon.centerYAnchor.constraint(equalTo: self.coloredRingView.topAnchor, constant: 10).isActive = true
        self.addIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.addIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.addIcon.layer.cornerRadius = 20 / 2
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
