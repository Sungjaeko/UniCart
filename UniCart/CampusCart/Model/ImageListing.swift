//
//  Listing.swift
//  CampusCart
//
//  Created by Sung Jae Ko on 10/2/23.
//

import Foundation


struct ImageListing: Hashable, Codable, Identifiable {
    var id: String
    var title: String
    var description: String
    var price: Int
    var profileImageUrl: String?
    
}
