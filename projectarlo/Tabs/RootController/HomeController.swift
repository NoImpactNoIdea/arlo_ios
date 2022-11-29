//
//  HomeController.swift
//  projectarlo
//
//  Created by Charlie Arcodia on 11/28/22.
//

import Foundation
import UIKit
import Firebase

import UIKit

class NoHighlight: UIButton {
override open var isHighlighted: Bool {
    didSet {
        alpha = isHighlighted ? 1.0 : 1.0
    }
  }
}

class HomeController : UITabBarController {
    
    static var vc : HomeController?
    
    private let databaseRef = Database.database().reference(),
                mainController = MainController()
    
    let redNotificationDot : UIView = {
        
        let rnd = UIView()
        rnd.translatesAutoresizingMaskIntoConstraints = false
        rnd.backgroundColor = coreRedColor
        rnd.isHidden = true
        
       return rnd
    }()
    
    func shouldShowNewMatchNotification(shouldShow : Bool) {
        
        if shouldShow {
            self.redNotificationDot.isHidden = false
        } else {
            self.redNotificationDot.isHidden = true
        }
        
    }
    
    private var viewHasBeenLaidOut: Bool = false
    
    var statusBarHeight: CGFloat = 0.0,
        keyWindow: UIWindow = UIWindow(),
        hasMainLockScreenBeenPresented: Bool = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.view.backgroundColor = coreBackgroundColor
        self.tabBar.backgroundColor = corePurpleColor
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.layer.zPosition = 10
        self.tabBar.shadowImage = UIImage()
        
        self.tabBar.clipsToBounds = false
        self.tabBar.layer.masksToBounds = false
        self.tabBar.layer.shadowColor = coreBlackColor.withAlphaComponent(0.8).cgColor
        self.tabBar.layer.shadowOpacity = 0.12
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.tabBar.layer.shadowRadius = 5
        self.tabBar.layer.shouldRasterize = false
        
        // for text displayed below the tabBar item
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: coreDeepColor], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: coreUltraLightColor], for: .normal)
        
        self.tabBar.unselectedItemTintColor = coreWhiteColor
       
        self.addTabsAndCustomCenterCircle {
        }
        
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:UIFont(name: ralewaySemiBold, size: 10), NSAttributedString.Key.foregroundColor: coreWhiteColor]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
    }
   
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        guard let insetsTop = self.view.window?.safeAreaInsets.top else { return }
        guard let insetsBottom = self.view.window?.safeAreaInsets.bottom else { return }

        globalStatusBarHeight = insetsTop
        globalFooterHeight = insetsBottom

        if insetsTop > CGFloat(30.0) {
            self.statusBarHeight = insetsTop
        } else {
            self.statusBarHeight = 30
            globalStatusBarHeight = 30
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if self.viewHasBeenLaidOut == true { return }
        self.viewHasBeenLaidOut = true
        
        guard let insets = self.view.window?.safeAreaInsets.top else { return }
        
        if insets > CGFloat(30.0) {
            self.statusBarHeight = insets
        } else {
            self.statusBarHeight = 30
            globalStatusBarHeight = 30
        }
    }
   
    @objc func handleMiddleTab() {
        
        UIDevice.vibrateLight()
        if self.selectedIndex == 1 {
            self.upDownHappyFaceAnimation(shouldGoDown: true)
        } else {
            self.switchTabs(tabIndex: 1)
        }
    }
    
    var happyButtonCenterYConstaint : NSLayoutConstraint?
    
    private func addTabsAndCustomCenterCircle(completion: @escaping () -> ()) {
        
        let callsNormal = UIImage(named: "home_nav_icon")?.withRenderingMode(.alwaysOriginal).withTintColor(coreWhiteColor)
        let callsSelected = UIImage(named: "home_nav_icon")?.withRenderingMode(.alwaysOriginal).withTintColor(matcherGold)

        //MARK: - CALLS TAB
        let mainController = UINavigationController(rootViewController: self.mainController)
//        self.mainController.homeController = self
        mainController.navigationBar.isHidden = true
        
        viewControllers = [mainController]
        
        completion()
    }
    
    func hideBottomToolBar(shouldHide : Bool) {
        
        if shouldHide {
            
            UIView.animate(withDuration: 0.1) {
                self.tabBar.alpha = 0.0
                self.layout()
            }
            
        } else {
            
            UIView.animate(withDuration: 0.05) {
                self.tabBar.alpha = 1.0
                self.layout()
            }
        }
    }
    
    func layout() {
        self.view.layoutIfNeeded()
        self.view.layoutSubviews()
    }
    
    func upDownHappyFaceAnimation(shouldGoDown : Bool) {
        
        if shouldGoDown {
           
            UIView.animate(withDuration: 0.18, delay: 0, options: .curveEaseInOut) {
                self.happyButtonCenterYConstaint?.constant = 35
                self.layout()
            } completion: { complete in
                print("face is down")
            }
        } else {
           
            UIView.animate(withDuration: 0.18, delay: 0, options: .curveEaseInOut) {
                self.happyButtonCenterYConstaint?.constant = 0
                self.layout()

            } completion: { complete in
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut) {
                    self.layout()

                } completion: { complete in
                    UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut) {
                        self.layout()

                    } completion: { complete in
                        print("face animate is open")
                    }
                }
            }
        }
    }
    
    func switchTabs(tabIndex: Int) {
        self.selectedIndex = tabIndex
    }
}
