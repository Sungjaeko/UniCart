//
//  DropdownMenuOption.swift
//  CampusCart
//
//  Created by Sung Jae Ko on 11/8/23.
//

import Foundation

struct DropdownMenuOption: Identifiable, Hashable {
    let id = UUID().uuidString
    let option: String
}

extension DropdownMenuOption {
    static let testSingleCondition: DropdownMenuOption = DropdownMenuOption(option: "New")
    static let testAllConditions: [DropdownMenuOption] = [
        DropdownMenuOption(option: "New"),
        DropdownMenuOption(option: "Used - Like New"),
        DropdownMenuOption(option: "Used - Good"),
        DropdownMenuOption(option: "Used - Fair")
    ]
}
