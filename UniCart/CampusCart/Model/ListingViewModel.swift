//
//  ListingViewModel.swift
//  CampusCart
//
//  Created by Sung Jae Ko on 10/20/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import UIKit
import FirebaseStorage
class ListingViewModel: ObservableObject {
    func saveImage(photo: Photo, image: UIImage) async -> Bool {
        
        let photoName = UUID().uuidString
        let storage = Storage.storage()
        let storageRef = storage.reference().child(\()/\()/.jpeg)
    }
}
