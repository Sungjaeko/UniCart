//
//  HousingViewModel.swift
//  CampusCart
//
//  Created by Sung Jae Ko on 11/27/23.
//

import SwiftUI
import Foundation
import Firebase
import PhotosUI
import FirebaseStorage

class HousingViewModel: ObservableObject {
    @Published private(set) var selectedImages: [UIImage] = []
    @Published var imageSelections: [PhotosPickerItem] = [] {
        didSet{
            setImages(from: imageSelections)
        }
    }
    
    func saveHousingPostImages(items: [PhotosPickerItem], user: User?,listing: HousingListing){
        guard let user else { print("sorry no user")
            return
        }
        Task{
            for item in items{
                guard let data = try await item.loadTransferable(type:Data.self) else {return}
                let (path) = try await StorageManager.shared.userSaveHousingImages(data: data, userId: user.id,listing: listing)
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

