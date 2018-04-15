//
//  AppDelegate.swift
//  ITunesStartProject
//
//  Created by Artem Zemtsov on 11/04/2018.
//  Copyright © 2018 Artem Zemtsov. All rights reserved.
//

import UIKit
import Dip
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private var container = DependencyContainer.configure()
    
    public var di : DependencyContainer {return container}
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.sharedManager().enable = true
        return true
    }

}

