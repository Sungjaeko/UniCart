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
    //@StateObject private var newListing = ImgListing()
    //@Binding var retrievedImages: [UIImage]
    @StateObject var sharedData = ImagesList.shared
    @StateObject var itemListings = ImgListing.sharedListings
    var body: some View {
        
        NavigationView{
            VStack{
                NavigationLink(destination: PostView()){
                    Text("New Post")
                }
                
                List{
                    ForEach(itemListings.listings, id: \.self) { listing in
                        HStack{
                            ForEach(listing.img, id: \.self){image in
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                            }
                            Text(listing.title)
                            Text("Condition: \(listing.condition)")
                        }
                    }
                }
                .navigationBarTitle("Items")
                
            }
        }
    }
}


struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView()
    }
}
