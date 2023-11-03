//
//  User.swift
//  CampusCart
//
//  Created by Sung Jae Ko on 10/2/23.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    var id: String
    var firstName: String
    var lastName: String
    var email: String
    var profileImageUrl: String?
    
    func initials() -> String{
        let firstInitial = firstName.first!
        let secondInitial = lastName.first!
        
        var combinedInitial = ""
        combinedInitial.append(firstInitial)
        combinedInitial.append(secondInitial)
        return combinedInitial
    }
    
    func fullName() -> String{
        return firstName + " " + lastName
    }
    
    
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, firstName: "Bat", lastName: "Man", email: "test@gmail.com", profileImageUrl: "batman-1")
}
