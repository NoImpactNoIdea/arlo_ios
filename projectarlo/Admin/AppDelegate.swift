//
//  AppDelegate.swift
//  projectarlo
//
//  Created by Charlie Arcodia on 11/28/22.
//

import UIKit
import SDWebImage
import Firebase
import NotificationCenter
import AVFoundation

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //FIREBASE CONFIGURATION
        FirebaseApp.configure()
        
        Database.database().isPersistenceEnabled = false
        
        //firebase messaging
        Messaging.messaging().delegate = self
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default, options: [.mixWithOthers])
        } catch _ {
            print("catch")
        }
        
        // CONFIGURE PUSH NOTIFICATIONS
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in
            
        })
        
        application.registerForRemoteNotifications()
        
        SDImageCache.shared.config.maxDiskAge = 3600 * 24 * 7 // 1 Week - 60 * 5 ///5 minutes// 3600 * 24 * 7 // 1 Week
        SDImageCache.shared.config.maxMemoryCost = 1024 * 1024 * 4 * 20 // 20 images (1024 * 1024 pixels)
        SDImageCache.shared.config.shouldCacheImagesInMemory = false // Disable memory cache, may cause cell-reusing flash because disk query is async
        SDImageCache.shared.config.shouldUseWeakMemoryCache = false // Disable weak cache, may see blank when return from background because memory cache is purged under pressure
        SDImageCache.shared.config.diskCacheReadingOptions = .mappedIfSafe // Use mmap for disk cache query
        
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

