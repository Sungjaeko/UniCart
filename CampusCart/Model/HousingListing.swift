//
//  HousingListing.swift
//  CampusCart
//
//  Created by Sung Jae Ko on 11/27/23.
//

import Foundation
import SwiftUI

class HousingListing: ObservableObject, Identifiable, Hashable {
    static let sharedListings = HousingListing()
    
    @Published var listings = [HousingListing]()
    @Published var id: String = ""
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var price: Int = 0
    @Published var imgURL: String = ""
    @Published var img = [UIImage]()
    
    static func == (lhs: HousingListing, rhs: HousingListing) -> Bool {
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
