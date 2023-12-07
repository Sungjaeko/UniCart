//
//  ContentView.swift
//  CampusCart
//
//  Created by Bryan Apodaca on 9/19/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                MainView()
            } else {
                LoginView2()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    //static let myEnvObject = AuthViewModel()
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel())
    }
}
