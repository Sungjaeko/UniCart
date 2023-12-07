//
//  DropdownMenuListRow.swift
//  CampusCart
//
//  Created by Sung Jae Ko on 11/8/23.
//

import SwiftUI

struct DropdownMenuListRow: View {
    let option: DropdownMenuOption
    
    // An action called when user select an action.
    let onSelectedAction: (_ option: DropdownMenuOption) -> Void
    
    var body: some View {
        Button(action: {
            self.onSelectedAction(option)
        }) {
            Text(option.option)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundColor(.black)
        .padding(.vertical, 5)
        .padding(.horizontal)
    }
}

struct DropdownMenuListRow_Previews: PreviewProvider {
    static var previews: some View {
        DropdownMenuListRow(option: DropdownMenuOption.testSingleCondition,
        onSelectedAction: {_ in})
    }
}
