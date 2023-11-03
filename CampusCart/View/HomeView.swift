//
//  HomeView.swift
//  CampusCart
//
//  Created by Bryan Apodaca on 10/3/23.
//

import SwiftUI

struct HomeView: View {
    @State var isHolding = true
    @State var search: String = ""
    var body: some View {
        ZStack{
//            Color.gray
//                .opacity(0.05)
//                .ignoresSafeArea()
            VStack{
                ZStack {
                    Rectangle()
                        .fill(.white)
                        .frame(height: 60)
                        .cornerRadius(10)
                        .shadow(radius: 3, x:2, y: 3)
                        
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .padding()
                        TextField("Search", text: $search, prompt: Text("Search")
                            .foregroundColor(.gray.opacity(0.9)))
                    }
                }
                .padding()
                Spacer()
                NavigationView{
                    VStack{
                        HStack {
                            Button(action: {
                                isHolding = false
                                print("Button pressed")
                                
                            }){
                                //let listModel = ListViewModel()
                                /*
                                NavigationLink(destination: ItemsView(listings: $listings)){
                                    HomeViewButtonView(text: "Items", imageName: "cart", isHolding: isHolding)
                                }*/
                            }
                            
                            Button(action: {
                                print("Button pressed")
                            }){
                                NavigationLink(destination:HousingView()){
                                    HomeViewButtonView(text: "Housing", imageName: "house", isHolding: isHolding)
                                }
                                
                            }
                            
                        }
                        HStack {
                            Button(action: {
                                print("Button pressed")
                            }){
                                NavigationLink(destination:SidejobsView()){
                                    HomeViewButtonView(text: "Side Jobs", imageName: "briefcase", isHolding: isHolding)
                                }
                            }
                            
                            Button(action: {
                                print("Button pressed")
                            }){
                                NavigationLink(destination:MiscView()){
                                    HomeViewButtonView(text: "Misc.", imageName: "questionmark", isHolding: isHolding)
                                }
                            }
                        }
                    }
                }
                    
                Spacer()
                
                
            }
        }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
