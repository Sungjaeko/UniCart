//
//  PostViewModel.swift
//  CampusCart
//
//  Created by Bryan Apodaca on 11/7/23.
//

import SwiftUI
import Foundation
import Firebase
import PhotosUI
import FirebaseStorage


class PostViewModel: ObservableObject{
    @Published private(set) var selectedImages: [UIImage] = []
    @Published var imageSelections: [PhotosPickerItem] = [] {
        didSet{
            setImages(from: imageSelections)
        }
    }
    
    
    func savePostImages(items: [PhotosPickerItem], user: User?,listing: ImgListing) async throws -> String{
        guard let user else { print("sorry no user")
            return "Error"
        }
        /*
        Task{
            for item in items{
                guard let data = try await item.loadTransferable(type:Data.self) else {return}
                // Removed "name" from the let statement that used to be included with path inside parentheses
                let path = try await StorageManager.shared.userSaveImages(data: data, userId: user.id,listing: listing)
                //let image = UIImage(data: data)
                //listing.img.append(image!)
                print("Path from savePostImages:\(path)")
                
                //print("Success!!")
                //listing.imgURL = path
                return path
           }
            
            
        }*/
        var firstPath: String?
        do {
               try await withThrowingTaskGroup(of: Void.self) { taskGroup in
                   for item in items {
                       guard let data = try await item.loadTransferable(type: Data.self) else {
                           continue
                       }
                       let path = try await StorageManager.shared.userSaveImages(data: data, userId: user.id, listing: listing)
                       print("Path from savePostImages: \(path)")

                       // Store the path from the first successfully saved image
                       if firstPath == nil {
                           firstPath = path
                       }

                       // You can break the loop if you only want the path from the first image
                       // taskGroup.cancelAll()
                   }
               }

               // Return the path from the first successfully saved image, or a default value
               return firstPath ?? "No images were successfully saved."
           } catch {
               print("Error saving images: \(error)")
               throw error
           }
    }
    
    func savePostImage(items: [PhotosPickerItem]){
        
        Task{
            for item in items{
                guard let data = try await item.loadTransferable(type:Data.self) else {return}
                let (path, name) = try await StorageManager.shared.userSaveImage(data: data)
                print("Success!!")
                print(path)
                print(name)}
            
        }
    }
    func setImages(from selections: [PhotosPickerItem]) {
        Task {
            var images: [UIImage] = []
            for selection in selections {
                if let data = try? await selection.loadTransferable(type: Data.self){
                    if let uiImage = UIImage(data: data){
                        images.append(uiImage)
                        
                    }
                }
            }
            selectedImages = images
        }
    }
//    func retrievePhotos(retrievedImages: [UIImage]) {
//        // Get the data from the database
//        let db = Firestore.firestore()
//
//        db.collection("images").getDocuments { snapshot, error in
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
//                                
//                                DispatchQueue.main.async {
//                                    retrievedImages.append(image)
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
        // Get the image data in storage for each image reference
        
        // Display the images
}
