//
//  AppDelegate.swift
//  Føtex Løn
//
//  Created by Martin Lok on 22/07/2016.
//  Copyright © 2016 Martin Lok. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var dataController: DataController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        dataController = DataController()
        setManagedObjectContext()
        
        registerDefaults()
        
        setGlobalColors()
        
        let vagt = Vagt(startTime: Date(), endTime: Date(timeIntervalSinceNow: 3600), pause: true)
        let vagt1 = Vagt(startTime: Date(timeIntervalSinceNow: 10800), endTime: Date(timeIntervalSinceNow: 32400), pause: true)
        
        vagter.append(vagt)
        vagter.append(vagt1)
        
        return true
    }
    
    // MARK: Functions
    
    func setGlobalColors() {
        UINavigationBar.appearance().tintColor = UIColor.white
        UIApplication.shared.statusBarStyle = .lightContent
        //UINavigationBar.appearance().backgroundColor = fotexBlue
    }
    
    // MARK: CoreData

    private func setManagedObjectContext() {
        let tabBarController = window?.rootViewController as! UITabBarController
        let mainNavigationController = tabBarController.viewControllers![0] as! UINavigationController
        let mainVC = mainNavigationController.viewControllers[0] as! MainVC
        mainVC.managedObjectContext = self.dataController.managedObjectContext
        
        let vagterNavigationController = tabBarController.viewControllers![1] as! UINavigationController
        let vagterVC = vagterNavigationController.viewControllers[0] as! VagterVC
        vagterVC.managedObjectContext = self.dataController.managedObjectContext
    }
//    
//    lazy var managedObjectContext: NSManagedObjectContext = {
//        guard let modelURL = Bundle.main.urlForResource("CoreDataModel", withExtension: "momd") else {
//            fatalError("Could not find data model in app bundle")
//        }
//        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
//            fatalError("Error initializing model from: \(modelURL)")
//        }
//        let urls = FileManager.default.urlsForDirectory( .documentDirectory, inDomains: .userDomainMask)
//        let documentsDirectory = urls[0]
//        var storeURL: URL?
//        do {
//            storeURL = try documentsDirectory.appendingPathComponent("DataStore.sqlite")
//        } catch {
//            print(error)
//        }
//        
//        do {
//            let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
//            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
//            
//            let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//            context.persistentStoreCoordinator = coordinator
//            
//            return context
//        } catch {
//            fatalError("Error adding persistent store at \(storeURL): \(error)")
//        }
//    }()
    
    // MARK: UserDefaults
    
    private func registerDefaults() {
        let defaultsDic = [kFirstTime: true]
        UserDefaults.standard.register(defaults: defaultsDic)
    }
    
    // MARK: - Other AppDelegate Funcs
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

