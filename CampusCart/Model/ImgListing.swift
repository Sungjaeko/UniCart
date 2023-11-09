//
//  ImgListing.swift
//  CampusCart
//
//  Created by Bryan Apodaca on 11/7/23.
//

import Foundation

class ImgListing: ObservableObject{
    @Published var id: String = ""
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var price: Int = 0
    @Published var condition = ""
}
