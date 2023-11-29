//
//  MiscViewModel.swift
//  CampusCart
//
//  Created by Sung Jae Ko on 11/28/23.
//

import SwiftUI
import Foundation
import Firebase
import PhotosUI
import FirebaseStorage


class MiscViewModel: ObservableObject{
    @Published private(set) var selectedImages: [UIImage] = []
    @Published var imageSelections: [PhotosPickerItem] = [] {
        didSet{
            setImages(from: imageSelections)
        }
    }
    
    func savePostImages(items: [PhotosPickerItem], user: User?,listing: MiscListing)async throws -> String{
        guard let user else { print("sorry no user")
            return "Error"
        }
        var firstPath: String?
        do {
               try await withThrowingTaskGroup(of: Void.self) { taskGroup in
                   for item in items {
                       guard let data = try await item.loadTransferable(type: Data.self) else {
                           continue
                       }
                       let path = try await MiscStorageManager.shared.userSaveImages(data: data, userId: user.id, listing: listing)
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
}
