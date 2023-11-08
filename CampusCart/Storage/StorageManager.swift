//
//  StorageManager.swift
//  CampusCart
//
//  Created by Shanni Tsoi on 11/3/23.
//

import Foundation
import FirebaseStorage

final class StorageManager{
    static let shared = StorageManager()
    private init() { }
    
    private let storage = Storage.storage().reference()
    
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
