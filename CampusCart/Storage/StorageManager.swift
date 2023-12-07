//
//  StorageManager.swift
//  CampusCart
//
//  Created by Shanni Tsoi on 11/3/23.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore

final class StorageManager{
    static let shared = StorageManager()
    private init() { }
    
    private let storage = Storage.storage().reference()
    
    private var imagesReference: StorageReference {
        storage.child("images")
    }
    
    private func userReference(userId: String) -> StorageReference {
        storage.child("users").child(userId)
    }
    
    // Saves images in a folder according to user
    func userSaveImages(data: Data, userId: String, listing: ImgListing) async throws -> String{
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        let imgID = "\(UUID().uuidString).jpeg"
        let path = "users/\(userId)/\(imgID)"
        
 
        let returnedMetaData = try await userReference(userId: userId).child(imgID).putDataAsync(data, metadata: meta)
        
        
        guard let returnedPath = returnedMetaData.path, let returnedName = returnedMetaData.name else{
            throw URLError(.badServerResponse)
        }
        
        let db = Firestore.firestore()
        try await db.collection("listings").document().setData(["url":path,
                                                                "title":listing.title,
                                                                "price":listing.price,
                                                                "description":listing.description,
                                                                "id":listing.id,
                                                                "condition":listing.condition])
        listing.upUrl(path: path)
        print("Path from userSaveImages:\(path)")
        return (path)
    }
    
   
}
