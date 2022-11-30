//
//  HomeController.swift
//  projectarlo
//
//  Created by Charlie Arcodia on 11/28/22.
//

import Foundation
import UIKit
import Firebase
import Lottie
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
                messageController = MessageController(),
                heartController = HeartController(),
                searchController = SearchController(),
                dummyController = DummyController()

    
    var pulseAnimation : LottieAnimationView = {
        
        let lav = LottieAnimationView.init(name: "purple_pulse")
        lav.translatesAutoresizingMaskIntoConstraints = false
        lav.loopMode = .playOnce
        lav.animationSpeed = 1.0
        lav.backgroundBehavior = .pauseAndRestore
    
       return lav
    }()
   

    
    let redNotificationDot : UIView = {
        
        let rnd = UIView()
        rnd.translatesAutoresizingMaskIntoConstraints = false
        rnd.backgroundColor = coreAccentColor
        rnd.isHidden = true
        
       return rnd
    }()
    
    lazy var centerButton : NoHighlight = {
        
        let hfb = NoHighlight()
        hfb.translatesAutoresizingMaskIntoConstraints = false
        hfb.backgroundColor = coreMediumColor
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .light)
        let image = UIImage(systemName: "plus", withConfiguration: config)
        hfb.setImage(image, for: UIControl.State.normal)
        hfb.tintColor = coreWhiteColor
        hfb.translatesAutoresizingMaskIntoConstraints = false
        hfb.isUserInteractionEnabled = true
        hfb.imageView?.contentMode = .scaleAspectFit
        
        hfb.clipsToBounds = false
        hfb.layer.masksToBounds = false
        hfb.layer.shadowColor = coreMediumColor.withAlphaComponent(1.0).cgColor
        hfb.layer.shadowOpacity = 0.3
        hfb.layer.shadowOffset = CGSize(width: 0, height: 20)
        hfb.layer.shadowRadius = 15
        hfb.layer.shouldRasterize = false
        hfb.isUserInteractionEnabled = true
        hfb.addTarget(self, action: #selector(self.handlePostController), for: .touchUpInside)
        
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
    
    @objc func handlePostController() {
        
        let postController = PostController()
        let nav = UINavigationController(rootViewController: postController)
        nav.modalPresentationStyle = .popover
        nav.navigationBar.isHidden = true
        
        self.navigationController?.present(nav, animated: true)
        
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tabBar.itemSpacing = 10
    }
    
    private func addTabsAndCustomCenterCircle(completion: @escaping () -> ()) {
        
        let configOne = UIImage.SymbolConfiguration(pointSize: 19.5, weight: .light)
        let imageOne = UIImage(systemName: "square.on.square.fill", withConfiguration: configOne)?.withTintColor(coreAccentColor).withRenderingMode(.alwaysOriginal)
        
        let configTwo = UIImage.SymbolConfiguration(pointSize: 19.5, weight: .light)
        let imageTwo = UIImage(systemName: "bubble.middle.bottom", withConfiguration: configTwo)?.withTintColor(coreMediumColor).withRenderingMode(.alwaysOriginal)
        
        let configThree = UIImage.SymbolConfiguration(pointSize: 19.5, weight: .light)
        let imageThree = UIImage(systemName: "magnifyingglass", withConfiguration: configThree)?.withTintColor(coreMediumColor).withRenderingMode(.alwaysOriginal)
        
        let configFour = UIImage.SymbolConfiguration(pointSize: 19.5, weight: .light)
        let imageFour = UIImage(systemName: "heart", withConfiguration: configFour)?.withTintColor(coreMediumColor).withRenderingMode(.alwaysOriginal)
        
        let configFive = UIImage.SymbolConfiguration(pointSize: 19.5, weight: .light)
        let imageFive = UIImage(systemName: "heart", withConfiguration: configFive)?.withTintColor(coreMediumColor).withRenderingMode(.alwaysOriginal)
       
       
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
        
        //MARK: - CALLS TAB
        let heartController = UINavigationController(rootViewController: self.heartController)
        self.heartController.homeController = self
        heartController.navigationBar.isHidden = true
        heartController.tabBarItem = UITabBarItem(title: "", image: imageFour, selectedImage: imageFour)
        
        //MARK: - CALLS TAB
        let searchController = UINavigationController(rootViewController: self.searchController)
        self.searchController.homeController = self
        searchController.navigationBar.isHidden = true
        searchController.tabBarItem = UITabBarItem(title: "", image: imageThree, selectedImage: imageThree)
        
        //MARK: - CALLS TAB
        let dummyController = UINavigationController(rootViewController: self.dummyController)
        dummyController.navigationBar.isHidden = true
        dummyController.tabBarItem = UITabBarItem(title: "", image: imageFive, selectedImage: imageFour)

        viewControllers = [mainController, searchController, dummyController, heartController, messagesController]
        
        guard let mainTabFrame = self.tabBar.items![0].value(forKey: "view") as? UIView else {return}///fetches the frame to place the notification circle
        guard let centerTab = self.tabBar.items![2].value(forKey: "view") as? UIView else {return}
        centerTab.isUserInteractionEnabled = false
        
        self.tabBar.addSubview(self.centerButton)
        self.centerButton.centerXAnchor.constraint(equalTo: self.tabBar.centerXAnchor, constant: 0).isActive = true
        self.centerButton.centerYAnchor.constraint(equalTo: mainTabFrame.centerYAnchor, constant: -15).isActive = true
        self.centerButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.centerButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        self.centerButton.layer.cornerRadius = 60/2
       
        self.tabBar.addSubview(self.redNotificationDot)
        self.redNotificationDot.topAnchor.constraint(equalTo: mainTabFrame.bottomAnchor, constant: -10).isActive = true
        self.redNotificationDot.centerXAnchor.constraint(equalTo: mainTabFrame.centerXAnchor).isActive = true
        self.redNotificationDot.heightAnchor.constraint(equalToConstant: 2.5).isActive = true
        self.redNotificationDot.widthAnchor.constraint(equalToConstant: 10).isActive = true
        self.redNotificationDot.layer.cornerRadius = 2.5 / 2
        
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
