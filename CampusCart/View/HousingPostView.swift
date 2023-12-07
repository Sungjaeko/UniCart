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

class HousingImagesList: ObservableObject{
    static let shared = HousingImagesList()
    
    @Published var retrievedImages = [UIImage]()
}



struct HousingPostView: View {
    //@Binding var listings: [ImageListing]
    let db = Firestore.firestore()
    @StateObject var photoViewModel = PhotoPickerViewModel()
    @StateObject private var viewModel = HousingViewModel()
    @StateObject private var authViewModel = AuthViewModel()
    @State var itemName: String = ""
    @State var description: String = ""
    @State var price: Int = 0
    @StateObject var itemListings = HousingListing.sharedListings
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedItems: [PhotosPickerItem] = []
    @StateObject var newHousingListing = HousingListing()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            
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
                    else{
                        Text("No Images to show")
                    }
                    
                    PhotosPicker(selection: $photoViewModel.imageSelections, matching: .images, photoLibrary: .shared()){
                        Text("Select photos")
                    }
                    
                    Text("Required")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size:30, weight: .bold, design: .rounded))
                        .padding()
                    
                    TextField("Title",text:$itemName)
                        .frame(width: .infinity)
                        .padding(14)
                        .overlay{
                            RoundedRectangle(cornerRadius: 9)
                                .stroke(.gray.opacity(0.6), lineWidth: 2)
                        }
                        .padding()
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
                        newHousingListing.id = randomId
                        newHousingListing.title = itemName
                        newHousingListing.description = description
                        newHousingListing.price = price
                        Task{
                            do{
                                let path = try await viewModel.saveHousingPostImages(items: photoViewModel.imageSelections, user: authViewModel.mockUser,listing: newHousingListing)
                                
                                await MainActor.run{
                                    newHousingListing.imgURL = path
                                    retrievePhotos(listing: newHousingListing)
                                    
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
                    
                    //Divider()
                    
                }
            }
            
            
        }
        .navigationTitle("New Listing")
        .navigationBarTitleDisplayMode(.large)
        
        
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
    
    func retrievePhotos(listing: HousingListing) {
        // Get the data from the database
        let db = Firestore.firestore()
        
        db.collection("housing").getDocuments { snapshot, error in
            print("YOU GOT HERE 1")
            if error == nil && snapshot != nil {
                var paths = [String]()
                // Loop through all the returned docs
                for doc in snapshot!.documents {
                    // extract the file path and add to array
                    paths.append(doc["url"] as! String)
                }
                print("YOU GOT HERE 2")
                // Loop through each file path and fetch the data from the storage
                
                for path in paths {
                    // Get a reference to storage
                    print("Current path in db:\(path)")
                    print("Listing Path:\(listing.imgURL)")
                    if (path == listing.imgURL){
                        print("MATCH")
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
struct HousingPostView_Previews: PreviewProvider {
    static var previews: some View {
        HousingPostView()
            .environmentObject(PhotoPickerViewModel())
            .environmentObject(ImgListing())
    }
}
