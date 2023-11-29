//
//  MiscStorageManager.swift
//  CampusCart
//
//  Created by Sung Jae Ko on 11/28/23.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore

final class MiscStorageManager {
    static let shared = MiscStorageManager()
    private init() { }
    
    private let storage = Storage.storage().reference()
    
    private var imagesReference: StorageReference {
        storage.child("images")
    }
    
    private func userReference(userId: String) -> StorageReference {
        storage.child("users").child(userId)
    }
    
    
    // Saves images in a folder according to user
    func userSaveImages(data: Data, userId: String, listing: MiscListing) async throws -> (path:String,name:String){
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        let imgID = "\(UUID().uuidString).jpeg"
        let path = "users/\(userId)/\(imgID)"
        
 
        let returnedMetaData = try await userReference(userId: userId).child(imgID).putDataAsync(data, metadata: meta)
        
        
        guard let returnedPath = returnedMetaData.path, let returnedName = returnedMetaData.name else{
            throw URLError(.badServerResponse)
        }
        
        let db = Firestore.firestore()
        try await db.collection("miscellaneous").document().setData(["url":path,
                                                                "title":listing.title,
                                                                "price":listing.price,
                                                                "description":listing.description,
                                                                "id":listing.id])
        listing.upUrl(path: path)
        print("Path from userSaveImages:\(path)")
        return (returnedPath,returnedName)
    }
}
