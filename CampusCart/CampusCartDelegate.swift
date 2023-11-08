//
//  CampusCartDelegate.swift
//  CampusCart
//
//  Created by Sung Jae Ko on 9/27/23.
//

import SwiftUI
import FirebaseCore
import Foundation
import FirebaseAuth
import FirebaseFirestore


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
 
}
