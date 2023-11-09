//
//  CampusCartApp.swift
//  CampusCart
//
//  Created by Bryan Apodaca on 9/19/23.
//

import SwiftUI

@main
struct CampusCartApp: App {
        @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
        @StateObject var viewModel = AuthViewModel()
        
        var body: some Scene {
            WindowGroup {
                NavigationView {
                    ContentView()
                        .environmentObject(viewModel)
                }
            }
        }
    }

