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

class PostViewModel: ObservableObject{
    @Published private(set) var selectedImages: [UIImage] = []
    @Published var imageSelections: [PhotosPickerItem] = [] {
        didSet{
            setImages(from: imageSelections)
        }
    }
    
    func savePostImages(items: [PhotosPickerItem]){
        
        Task{
            for item in items{
                guard let data = try await item.loadTransferable(type:Data.self) else {return}
                let (path, name) = try await StorageManager.shared.saveImage(data: data)
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
}
