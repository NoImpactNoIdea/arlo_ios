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
        
        self.backgroundColor = coreWhiteColor
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
        return CGSize(width: 90, height: 100)///roughly height
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: self.spotlightID, for: indexPath) as! SpotLightFeeder
        cell.spotLightCollectionView = self
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
        let image = UIImage(named: "dummy_image")?.withRenderingMode(.alwaysOriginal)
        dcl.image = image
        
        return dcl
    }()
    
    lazy var coloredRingView : UIButton = {
        
        let cv = UIButton()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = coreMediumColor
        cv.layer.cornerRadius = 0
        cv.clipsToBounds = true
        
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = coreWhiteColor
        self.addViews()
        
    }
    
    func addViews() {
        
        self.addSubview(self.coloredRingView)
        self.addSubview(self.containerView)
        self.containerView.addSubview(self.profileImageView)
       
        self.containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        self.containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.containerView.heightAnchor.constraint(equalToConstant: 66).isActive = true
        self.containerView.widthAnchor.constraint(equalToConstant: 66).isActive = true
        self.containerView.layer.cornerRadius = 66/2

        self.profileImageView.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor, constant: 0).isActive = true
        self.profileImageView.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor, constant: 0).isActive = true
        self.profileImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.profileImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        self.profileImageView.layer.cornerRadius = 60/2
        
        self.coloredRingView.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor, constant: 0).isActive = true
        self.coloredRingView.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor, constant: 0).isActive = true
        self.coloredRingView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.coloredRingView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        self.coloredRingView.layer.cornerRadius = 70/2

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
