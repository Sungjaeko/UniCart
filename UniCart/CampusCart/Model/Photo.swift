//
//  Photo.swift
//  CampusCart
//
//  Created by Sung Jae Ko on 10/20/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Photo: Identifiable, Codable {
    @DocumentID var id: String?
    var imageURLString = ""
    var description = ""
    var creator = Auth.auth().currentUser?.email ?? ""
    var postDate = Date()
    
    var dictionary: [String: Any] {
        return ["imageURLString:" : imageURLString, "desription:" : description, "creator:" : creator, "postDate:" : Timestamp(date: Date()) ]
    }
}
