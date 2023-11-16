//
//  ImgListing.swift
//  CampusCart
//
//  Created by Bryan Apodaca on 11/7/23.
//

import Foundation
import SwiftUI

class ImgListing: ObservableObject, Identifiable, Hashable {
    
    static let sharedListings = ImgListing()
    
    @Published var listings = [ImgListing]()
    @Published var id: String = ""
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var price: Int = 0
    @Published var condition = ""
    @Published var imgURL: String = ""
    @Published var img = [UIImage]()
    
    static func == (lhs: ImgListing, rhs: ImgListing) -> Bool {
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
