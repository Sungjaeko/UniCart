//
//  ItemsView.swift
//  CampusCart
//
//  Created by Bryan Apodaca on 10/18/23.
//

import SwiftUI
import Combine
import Firebase
import FirebaseStorage

/*
 class ListViewModel: ObservableObject{
 @Published var items: [Listing] = []
 
 func addListing(id: String, title: String, desc: String, price: Int){
 let newItem = Listing(id: id,title: title,description: desc,price: price)
 items.append(newItem)
 }
 }*/
//class ImagesList: ObservableObject{
//    static let shared = ImagesList()
//
//    @Published var retrievedImages = [UIImage]()
//}

struct ItemsView: View {
    //@State var listings: [ImageListing]
    //@StateObject private var newListing = ImgListing()
    //@Binding var retrievedImages: [UIImage]
    @State private var searchText: String = ""
    @StateObject var sharedData = ImagesList.shared
    @StateObject var itemListings = ImgListing.sharedListings
    
    var filteredListings: [ImgListing] {
        if searchText.isEmpty {
            return itemListings.listings
        } else {
            return itemListings.listings.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationView{
            ScrollView {
                ZStack {
                    Rectangle()
                        .fill(.white)
                        .frame(height: 60)
                        .cornerRadius(10)
                        .shadow(radius: 3, x:2, y: 3)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .padding()
                        TextField("Search", text: $searchText, prompt: Text("Search")
                            .foregroundColor(.gray.opacity(0.9)))
                    }
                }
                .padding()
                VStack(alignment: .leading){
                    
                    NavigationLink(destination: PostView()){
                        Text("New Post")
                    }
                    .padding()
                    VStack (alignment: .leading){
                        ForEach(itemListings.listings, id: \.self) { listing in
                            HStack(alignment: .top){
                                ForEach(listing.img, id: \.self) {image in
                                    
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width:130,height:130)
                                        .cornerRadius(13)
                                }
                                
                                VStack (alignment: .leading){
                                    Text(listing.title)
                                        .font(.system(size:20, weight: .regular, design: .rounded))
                                    Text("Condition: \(listing.condition)")
                                        .font(.system(size:15, weight: .regular, design: .rounded))
                                    Text("$\(String(listing.price))")
                                        .font(.system(size:20, weight: .bold, design: .rounded))
                                }
                               
                            }
                            .padding()
                            Divider()
                        }
                    }
                    .navigationBarTitle("Items")
                    Spacer()
                }
                
            }
        }
    }
    
    
    
    //    func retrievePhotos() {
    //        // Get the data from the database
    //        let db = Firestore.firestore()
    //
    //        db.collection("listings").getDocuments { snapshot, error in
    //            if error == nil && snapshot != nil {
    //                var paths = [String]()
    //                // Loop through all the returned docs
    //                for doc in snapshot!.documents {
    //                    // extract the file path and add to array
    //                    paths.append(doc["url"] as! String)
    //                }
    //                // Loop through each file path and fetch the data from the storage
    //                for path in paths {
    //                    // Get a reference to storage
    //                    let storageRef = Storage.storage().reference()
    //
    //                    // Specify the path
    //                    let fileRef = storageRef.child(path)
    //
    //                    // Retrieve the data
    //                    fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
    //                        // Check for errors
    //                        if error == nil && data != nil{
    //
    //                            // Create a UIImage and put it into our array for display
    //                            if let image = UIImage(data: data!) {
    //                                //newListing.img = image
    //                                DispatchQueue.main.async {
    //                                    sharedData.retrievedImages.append(image)
    //                                }
    //                            }
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //    }
    
}



struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView()
    }
}
