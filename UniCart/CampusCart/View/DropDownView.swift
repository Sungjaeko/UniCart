//
//  DropDownView.swift
//  CampusCart
//
//  Created by Sung Jae Ko on 11/7/23.
//

import SwiftUI

struct DropDownView: View {
    @State private var selectedOption = 0
    let options = ["Option 1", "Option 2", "Option 3"]
    
    var body: some View {
       
                Picker(selection: $selectedOption, label: Text("Options")) {
                    ForEach(0..<options.count, id: \.self) { index in
                        Text(options[index]).tag(index)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            
            
        .navigationTitle("Dropdown Example")
    }
}

struct DropDownView_Previews: PreviewProvider {
    static var previews: some View {
        DropDownView()
    }
}
