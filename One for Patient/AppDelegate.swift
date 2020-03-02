//
//  AppDelegate.swift
//  One for Patient
//
//  Created by Praneeth Althuru on 13/09/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import UserNotifications
import MobileRTC
import FirebaseInstanceID
import Firebase
import FirebaseMessaging



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    lazy private var backgroundTask: UIBackgroundTaskIdentifier = {
        let backgroundTask = UIBackgroundTaskIdentifier.invalid
        return backgroundTask
    }()
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        MARK: Firebase Configuration
        if #available(iOS 10.0, *) {
        
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
        options: authOptions,
        completionHandler: {_, _ in })
        // For iOS 10 data message (sent via FCM
        Messaging.messaging().delegate = self
        } else {
        let settings: UIUserNotificationSettings =
        UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        application.registerUserNotificationSettings(settings)
        }
         
        application.registerForRemoteNotifications()
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
        
        GlobalVariables.fcmToken = Messaging.messaging().fcmToken!
        print("fcmToken =\(GlobalVariables.fcmToken)" )
        
//        MARK: Device Token
        InstanceID.instanceID().instanceID { (result, error) in
          if let error = error {
            print("Error fetching remote instance ID: \(error)")
          } else if let result = result {
            print("Remote instance ID token: \(result.token)")
          }
        }
        
//        MARK: SC - Font
        let font = UIFont(name: "OpenSans", size: 15.0)
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font!], for: .normal)
        UITabBar.appearance().tintColor = .baseColor
        
        IQKeyboardManager.shared .enable = true;
//        MARK:Zoom Configuration
        ZoomService.sharedInstance.authenticateSDK()
        ReachabilityManager.shared.startMonitoring()
        UNUserNotificationCenter.current().delegate = self


//    MARK: Navigation
        let appdelegate = UIApplication.shared.delegate as! AppDelegate

        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginPageView = mainStoryboard.instantiateViewController(withIdentifier: "NewViewController") as! NewViewController
        let nav = UINavigationController(rootViewController: loginPageView)
        appdelegate.window!.rootViewController = nav
        
//        MARK:- Device ID
        GlobalVariables.deviceID = UIDevice.current.identifierForVendor!.uuidString
        print("deviceID = \(GlobalVariables.deviceID)")

//        MARK:Network Monitor
        ReachabilityManager.shared.startMonitoring()
        
         
        return true
    }
    
    
   func applicationDidEnterBackground(_ application: UIApplication) {
          
      }
      
   func applicationWillEnterForeground(_ application: UIApplication) {
          
      }
      
   func applicationWillTerminate(_ application: UIApplication) {
      }
      
     
       
   func applicationWillResignActive(_ application: UIApplication) {
       
    }

    

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        UIApplication.shared.applicationIconBadgeNumber = 0

    }

    

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "One_for_Patient")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
    if let error = error as NSError? {
                
    fatalError("Unresolved error \(error), \(error.userInfo)")
    }
    })
    return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
    do {
    try context.save()
    } catch {
                
    let nserror = error as NSError
    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
    }
    }
    }
      
     
      
      
    

}

extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {
    func applicationReceivedRemoteMessage(_ remoteMessage: MessagingRemoteMessage) {
    print("Notification Msg = \(remoteMessage.appData)")
    }
  
   
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
    print("Firebase registration token: \(fcmToken)")

    let dataDict:[String: String] = ["token": fcmToken]
    NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
      
    }
    
    
    
    
    
    //Here you get the callback for notification, if the app is in FOREGROUND.
    //Here you decide whether to silently handle the notification or still alert the user.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let id = notification.request.identifier
        print("Received notification with ID = \(id)")

        completionHandler([.alert, .sound])
    }


    
    
    
    
   
}


