//
//  ItemsView.swift
//  CampusCart
//
//  Created by Bryan Apodaca on 10/18/23.
//

import SwiftUI
import Combine

/*
class ListViewModel: ObservableObject{
    @Published var items: [Listing] = []
    
    func addListing(id: String, title: String, desc: String, price: Int){
        let newItem = Listing(id: id,title: title,description: desc,price: price)
        items.append(newItem)
    }
}*/


struct ItemsView: View {
    //@State var listings: [ImageListing]
    @StateObject private var newListing = ImgListing()
    
    var body: some View {
        
        NavigationView{
            VStack{
                NavigationLink(destination: PostView()){
                    Text("New Post")
                }
                /*
                List{
                    ForEach(listings){
                        listing in Text(listing.title)
                    }
                }
                .navigationBarTitle("Items")*/
                
            }
        }
    }
}
/*
func insertImage() async throws {
  
}*/

struct ItemsView_Previews: PreviewProvider {
    
    static var previews: some View {
        ItemsView()
    }
}
