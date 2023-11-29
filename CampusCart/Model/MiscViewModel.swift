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
    
    func savePostImages(items: [PhotosPickerItem], user: User?,listing: MiscListing){
        guard let user else { print("sorry no user")
            return
        }
        Task{
            for item in items{
                guard let data = try await item.loadTransferable(type:Data.self) else {return}
                // Removed "name" from the let statement that used to be included with path inside parentheses
                let (path) = try await MiscStorageManager.shared.userSaveImages(data: data, userId: user.id,listing: listing)
                //let image = UIImage(data: data)
                //listing.img.append(image!)
                print("Path from savePostImages:\(path)")
                
                //print("Success!!")
                //listing.imgURL = path
                
           }
            
            
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
