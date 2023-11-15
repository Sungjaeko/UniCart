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
    func userSaveImages(data: Data, userId: String) async throws -> (path:String,name:String){
        print(userId)
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        let imgID = "\(UUID().uuidString).jpeg"
        let path = "users/\(userId)/\(imgID)"
        
        
        let returnedMetaData = try await userReference(userId: userId).child(imgID).putDataAsync(data, metadata: meta)
        
        
        guard let returnedPath = returnedMetaData.path, let returnedName = returnedMetaData.name else{
            throw URLError(.badServerResponse)
        }
        
        let db = Firestore.firestore()
        try await db.collection("images").document().setData(["url":path])
            
            
        return (returnedPath,returnedName)
    }
    
    func userSaveImage(data: Data) async throws -> (path:String,name:String){
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        let path = "\(UUID().uuidString).jpeg"
        
        let returnedMetaData = try await imagesReference.child(path).putDataAsync(data, metadata: meta)
        
        
        guard let returnedPath = returnedMetaData.path, let returnedName = returnedMetaData.name else{
            throw URLError(.badServerResponse)
        }
                
        return (returnedPath,returnedName)
    }
    
    func saveImage(data: Data) async throws -> (path:String,name:String){
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        let path = "\(UUID().uuidString).jpeg"
        
        let returnedMetaData = try await storage.child(path).putDataAsync(data, metadata: meta)
        
        guard let returnedPath = returnedMetaData.path, let returnedName = returnedMetaData.name else{
            throw URLError(.badServerResponse)
        }
                
        return (returnedPath,returnedName)
    }
}
