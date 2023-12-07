//
//  PostView.swift
//  CampusCart
//
//  Created by Bryan Apodaca on 10/3/23.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage

class ImagesList: ObservableObject{
    static let shared = ImagesList()
    
    @Published var retrievedImages = [UIImage]()
}



struct PostView: View {
    let db = Firestore.firestore()
    @StateObject var photoViewModel = PhotoPickerViewModel()
    @StateObject private var viewModel = PostViewModel()
    @StateObject private var authViewModel = AuthViewModel()
    @State private var condition: DropdownMenuOption? = nil
    @State var itemName: String = ""
    @State var description: String = ""
    @State var price: Int = 0
    @StateObject var sharedData = ImagesList.shared
    @StateObject var itemListings = ImgListing.sharedListings
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedItems: [PhotosPickerItem] = []
    @StateObject var newListing = ImgListing()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack (alignment: .center) {
                        
                        if !photoViewModel.selectedImages.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack{
                                    ForEach(photoViewModel.selectedImages, id: \.self) { image in
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width:200,height:200)
                                            .cornerRadius(10)
                                    }
                                    
                                }
                            }
                        }
                        
                        
                        
                        Text("Required")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size:30, weight: .bold, design: .rounded))
                            .padding()
                        
                        PhotosPicker(selection: $photoViewModel.imageSelections, matching: .images, photoLibrary: .shared()){
                            Text("Select photos")
                        }
                        
                        TextField("Title",text:$itemName)
                            .frame(width: .infinity)
                            .padding(14)
                            .overlay{
                                RoundedRectangle(cornerRadius: 9)
                                    .stroke(.gray.opacity(0.6), lineWidth: 2)
                            }
                            .padding()
                        DropdownMenu(
                            selectedOption: self.$condition,
                            placeholder: "Select your condition",
                            options: DropdownMenuOption.testAllConditions)
                        TextField("Price",value: $price, format:.number)
                            .frame(width: .infinity)
                            .padding(14)
                            .overlay{
                                RoundedRectangle(cornerRadius: 9)
                                    .stroke(.gray.opacity(0.6), lineWidth: 2)
                            }
                            .padding()
                        TextField("Description",text:$description).foregroundColor(.gray.opacity(0.9))
                            .frame(width: .infinity,height:150,alignment:.top)
                            .padding(14)
                            .overlay{
                                RoundedRectangle(cornerRadius: 9)
                                    .stroke(.gray.opacity(0.6), lineWidth: 2)
                            }
                            .padding()
                        Button {
                            
                            let randomId = randomString(length: 10)
                            newListing.id = randomId
                            newListing.title = itemName
                            newListing.description = description
                            newListing.price = price
                            newListing.condition = condition?.option ?? "No Condition"
                            Task{
                                do{
                                    let path = try await viewModel.savePostImages(items: photoViewModel.imageSelections, user: authViewModel.mockUser,listing: newListing)
                                    await MainActor.run{
                                        newListing.imgURL = path
                                        retrievePhotos(listing: newListing)
                                        
                                    }
                                    
                                }
                            }
                            self.presentationMode.wrappedValue.dismiss()
                            
                            
                        } label: {
                            Text("Submit")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                        }
                        .frame(height:50)
                        .frame(maxWidth: 300)
                        .background(Color.blue)
                        
                        .cornerRadius(9)
                        .shadow(radius: 4 , x: 2, y: 3)
                        
                    }
                }
            }
        }
        
        
        
    }
    func randomString(length: Int) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""
        
        for _ in 0..<length {
            let randomIndex = Int.random(in: 0..<characters.count)
            let character = characters[characters.index(characters.startIndex, offsetBy: randomIndex)]
            randomString.append(character)
        }
        
        return randomString
    }
    
    func retrievePhotos(listing: ImgListing){
        // Get the data from the database
        let db = Firestore.firestore()
        
        db.collection("listings").getDocuments { snapshot, error in
            if error == nil && snapshot != nil {
                var paths = [String]()
                // Loop through all the returned docs
                for doc in snapshot!.documents {
                    // extract the file path and add to array
                    paths.append(doc["url"] as! String)
                }
                // Loop through each file path and fetch the data from the storage
                
                for path in paths {
                    if (path == listing.imgURL){
                        let storageRef = Storage.storage().reference()
                        
                        // Specify the path
                        let fileRef = storageRef.child(path)
                        
                        // Retrieve the data
                        fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                            // Check for errors
                            if error == nil && data != nil{
                                
                                // Create a UIImage and put it into our array for display
                                if let image = UIImage(data: data!) {
                                    //newListing.img = image
                                    DispatchQueue.main.async {
                                        listing.addImages(image: image)
                                        itemListings.listings.append(listing)
                                        
                                    }
                                }
                            }
                        }
                        break
                        
                    }
                    
                }
            }
        }
    }
    
}
struct PostView_Previews: PreviewProvider {
    @State static var listings: [ImageListing] = []
    static var previews: some View {
        PostView()
            .environmentObject(PhotoPickerViewModel())
            .environmentObject(ImgListing())
    }
}
