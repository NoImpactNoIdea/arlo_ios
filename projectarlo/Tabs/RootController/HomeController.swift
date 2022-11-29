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
                mainController = MainController(),
                messageController = MessageController()

    
    let redNotificationDot : UIView = {
        
        let rnd = UIView()
        rnd.translatesAutoresizingMaskIntoConstraints = false
        rnd.backgroundColor = coreDeepColor
        rnd.isHidden = true
        
       return rnd
    }()
    
    lazy var centerButton : NoHighlight = {
        
        let hfb = NoHighlight()
        hfb.translatesAutoresizingMaskIntoConstraints = false
        hfb.backgroundColor = coreMediumColor
        hfb.setBackgroundColor(color: coreRedColor, forState: .selected)
        
        let config = UIImage.SymbolConfiguration(pointSize: 22.5, weight: .light)
        let image = UIImage(systemName: "plus", withConfiguration: config)
        hfb.setImage(image, for: UIControl.State.normal)
        hfb.tintColor = coreWhiteColor
        hfb.translatesAutoresizingMaskIntoConstraints = false
        hfb.isUserInteractionEnabled = true
        hfb.imageView?.contentMode = .scaleAspectFit
        
       return hfb
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
       
        self.appearance()
        self.shouldShowNewMatchNotification(shouldShow: true)
        
    }
    
    func appearance() {
        
        self.view.backgroundColor = coreBackgroundColor
        self.tabBar.backgroundColor = coreWhiteColor
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.shadowImage = UIImage()
        
        self.tabBar.clipsToBounds = false
        self.tabBar.layer.masksToBounds = false
        
        // for text displayed below the tabBar item
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: coreDeepColor], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: coreUltraLightColor], for: .normal)
        
        self.tabBar.unselectedItemTintColor = coreMediumColor
       
        self.addTabsAndCustomCenterCircle {
            print("controllers loaded")
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
    
    private func addTabsAndCustomCenterCircle(completion: @escaping () -> ()) {
        
        let configOne = UIImage.SymbolConfiguration(pointSize: 22.5, weight: .light)
        let imageOne = UIImage(systemName: "note", withConfiguration: configOne)?.withTintColor(coreMediumColor).withRenderingMode(.alwaysOriginal)
        
        let configTwo = UIImage.SymbolConfiguration(pointSize: 22.5, weight: .light)
        let imageTwo = UIImage(systemName: "bubble.middle.bottom", withConfiguration: configTwo)?.withTintColor(coreMediumColor).withRenderingMode(.alwaysOriginal)
       
        //MARK: - CALLS TAB
        let mainController = UINavigationController(rootViewController: self.mainController)
        self.mainController.homeController = self
        mainController.navigationBar.isHidden = true
        mainController.tabBarItem = UITabBarItem(title: "", image: imageOne, selectedImage: imageOne)
        
        //MARK: - CALLS TAB
        let messagesController = UINavigationController(rootViewController: self.messageController)
        self.messageController.homeController = self
        messagesController.navigationBar.isHidden = true
        messagesController.tabBarItem = UITabBarItem(title: "", image: imageTwo, selectedImage: imageTwo)

        viewControllers = [mainController, messagesController]
        
        guard let mainTabFrame = self.tabBar.items![0].value(forKey: "view") as? UIView else {return}///fetches the frame to place the notification circle
        
        self.tabBar.addSubview(self.centerButton)
        self.centerButton.centerXAnchor.constraint(equalTo: self.tabBar.centerXAnchor, constant: 0).isActive = true
        self.centerButton.centerYAnchor.constraint(equalTo: mainTabFrame.centerYAnchor, constant: -5).isActive = true
        self.centerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.centerButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.centerButton.layer.cornerRadius = 50/2
        
        self.tabBar.addSubview(self.redNotificationDot)
        self.redNotificationDot.topAnchor.constraint(equalTo: mainTabFrame.bottomAnchor, constant: -5).isActive = true
        self.redNotificationDot.centerXAnchor.constraint(equalTo: mainTabFrame.centerXAnchor).isActive = true
        self.redNotificationDot.heightAnchor.constraint(equalToConstant: 5).isActive = true
        self.redNotificationDot.widthAnchor.constraint(equalToConstant: 5).isActive = true
        self.redNotificationDot.layer.cornerRadius = 2.5
        
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
    
    func switchTabs(tabIndex: Int) {
        self.selectedIndex = tabIndex
    }
}
