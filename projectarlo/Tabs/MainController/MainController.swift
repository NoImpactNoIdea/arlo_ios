//
//  MainController.swift
//  projectarlo
//
//  Created by Charlie Arcodia on 11/28/22.
//

import Foundation
import UIKit

class MainController : UIViewController {
    
    var homeController : HomeController?
    
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
        hfl.text = "Close by"
        hfl.textColor = coreDeepColor
        hfl.textAlignment = .left
        hfl.font = UIFont(name: ralewayExtraBold, size: 18)
        
        return hfl
    }()
    
    var viewAll : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "View all"
        hfl.textColor = coreLightColor
        hfl.textAlignment = .right
        hfl.font = UIFont(name: ralewayExtraBold, size: 14)
        
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
    
    var hasViewLoaded : Bool = false
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if self.hasViewLoaded == false {
            if self.mainCardFeederView.frame.height != 0.0 {
                self.hasViewLoaded = true
                self.dummyCall()

            }
        }
    }
    
   @objc func dummyCall() {
        
        let viewOne = UIView()
        let viewTwo = UIView()
        let cardArray = [viewOne, viewTwo]
        self.mainCardFeederView.startRotation(cardArray: cardArray)
        
    }
    
    func addViews() {
        
        self.view.addSubview(self.mainHeaderCell)
        self.view.addSubview(self.spotLightCollectionView)
        self.view.addSubview(self.spotLightCollectionView)
        self.view.addSubview(self.nearYouLabel)
        self.view.addSubview(self.mainCardFeederView)
        self.view.addSubview(self.viewAll)

        self.mainHeaderCell.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        self.mainHeaderCell.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.mainHeaderCell.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.mainHeaderCell.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.spotLightCollectionView.topAnchor.constraint(equalTo: self.mainHeaderCell.bottomAnchor, constant: 10).isActive = true
        self.spotLightCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.spotLightCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.spotLightCollectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.viewAll.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40).isActive = true
        self.viewAll.topAnchor.constraint(equalTo: self.spotLightCollectionView.bottomAnchor, constant: 20).isActive = true
        self.viewAll.widthAnchor.constraint(equalToConstant: 70).isActive = true
        self.viewAll.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.nearYouLabel.centerYAnchor.constraint(equalTo: self.viewAll.centerYAnchor).isActive = true
        self.nearYouLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40).isActive = true
        self.nearYouLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.nearYouLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
//        self.nearYouLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
//        self.nearYouLabel.topAnchor.constraint(equalTo: self.spotLightCollectionView.bottomAnchor, constant: 20).isActive = true
//        self.nearYouLabel.rightAnchor.constraint(equalTo: self.nearYouLabel.leftAnchor, constant: -30).isActive = true
//        self.nearYouLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.mainCardFeederView.topAnchor.constraint(equalTo: self.viewAll.bottomAnchor, constant: 10).isActive = true
        self.mainCardFeederView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.mainCardFeederView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.mainCardFeederView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        
        
    }
}
