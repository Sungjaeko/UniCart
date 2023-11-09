//
//  HomeView.swift
//  CampusCart
//
//  Created by Sung Jae Ko on 10/2/23.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    //@Binding var listModel: ListViewModel
    var body: some View {
        //Text("Current Home view")
        TabView{
//            HomeView()
            HomeView()
                .tabItem{
                    Label("Home",systemImage: "house.fill")
                    Image(systemName: "house")
                }
            DMView()
                .tabItem{
                    Label("Message",systemImage:"message")
                }
            ProfileView(firstName: User.MOCK_USER.firstName, lastName: User.MOCK_USER.lastName, email: User.MOCK_USER.email)
                .tabItem{
                    Label("Profile",systemImage:"person.fill")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        //let listModel = ListViewModel()
        MainView()
    }
}
