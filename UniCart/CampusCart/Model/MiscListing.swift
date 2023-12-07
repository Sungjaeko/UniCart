//
//  MiscListing.swift
//  CampusCart
//
//  Created by Sung Jae Ko on 11/28/23.
//

import Foundation
import SwiftUI

class MiscListing: ObservableObject, Identifiable, Hashable {
    
    static let sharedListings = MiscListing()
    
    @Published var listings = [MiscListing]()
    @Published var id: String = ""
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var price: Int = 0
    @Published var imgURL: String = ""
    @Published var img = [UIImage]()
    
    static func == (lhs: MiscListing, rhs: MiscListing) -> Bool {
            return lhs.id == rhs.id
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    
    func addImages(image: UIImage){
        img.append(image)
    }
    func upUrl(path:String){
        imgURL = path
    }
}
