//
//  MainController.swift
//  projectarlo
//
//  Created by Charlie Arcodia on 11/28/22.
//

import Foundation
import UIKit

class MainController : UIViewController {
    
    lazy var mainHeaderCell : MainHeaderCell = {
        
        let mhc = MainHeaderCell()
        mhc.translatesAutoresizingMaskIntoConstraints = false
        
       return mhc
    }()
    
    lazy var spotLightCollectionView : SpotLightCollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let slcv = SpotLightCollectionView(frame: .zero, collectionViewLayout: layout)
        slcv.mainController = self
        
       return slcv
        
    }()
    
    var nearYouLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "Near you"
        hfl.textColor = coreDeepColor
        hfl.textAlignment = .left
        hfl.font = UIFont(name: ralewayExtraBold, size: 18)
        
        return hfl
    }()
    
    lazy var mainCardFeederView : MainCardFeederView = {
        
        let mhc = MainCardFeederView()
        mhc.translatesAutoresizingMaskIntoConstraints = false
        
       return mhc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreWhiteColor
        self.addViews()
        
    
    }
    
    func addViews() {
        
        self.view.addSubview(self.mainHeaderCell)
        self.view.addSubview(self.spotLightCollectionView)
        self.view.addSubview(self.spotLightCollectionView)
        self.view.addSubview(self.nearYouLabel)
        self.view.addSubview(self.mainCardFeederView)

        self.mainHeaderCell.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        self.mainHeaderCell.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.mainHeaderCell.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.mainHeaderCell.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.spotLightCollectionView.topAnchor.constraint(equalTo: self.mainHeaderCell.bottomAnchor, constant: 10).isActive = true
        self.spotLightCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.spotLightCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.spotLightCollectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.nearYouLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.nearYouLabel.topAnchor.constraint(equalTo: self.spotLightCollectionView.bottomAnchor, constant: 20).isActive = true
        self.nearYouLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.nearYouLabel.sizeToFit()
        
        self.mainCardFeederView.topAnchor.constraint(equalTo: self.nearYouLabel.bottomAnchor, constant: 50).isActive = true
        self.mainCardFeederView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.mainCardFeederView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.mainCardFeederView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
