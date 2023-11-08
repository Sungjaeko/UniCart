//
//  PostViewModel.swift
//  CampusCart
//
//  Created by Bryan Apodaca on 11/7/23.
//

import Foundation
import PhotosUI
import SwiftUI

class PostViewModel: ObservableObject{
    
    func savePostImage(item: PhotosPickerItem){
        
        Task{
            guard let data = try await item.loadTransferable(type:Data.self) else {return}
            let (path, name) = try await StorageManager.shared.saveImage(data: data)
            print("Success!!")
            print(path)
            print(name)
        }
    }
}
