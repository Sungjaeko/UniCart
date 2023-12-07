//
//  SwiftUIView.swift
//  CampusCart
//
//  Created by Sung Jae Ko on 11/8/23.
//

import SwiftUI

struct DropdownMenu: View {
    // Used to show or hide drop-down menu options
    @State private var isOptionsPresented: Bool = false
    
    // Used to bind user selection
    @Binding var selectedOption: DropdownMenuOption?
    
    // A placeholder for drop-down menu
    let placeholder: String
    
    // The drop-down menu options
    let options: [DropdownMenuOption]
    var body: some View {
        Button(action: {
            withAnimation {
                self.isOptionsPresented.toggle()
            }
        }) {
            HStack {
                Text(selectedOption == nil ? placeholder : selectedOption!.option)
                    .fontWeight((.medium))
                    .foregroundColor(selectedOption == nil ? .gray : .black)
                
                Spacer()
                
                Image(systemName: self.isOptionsPresented ? "chevron.up" : "chevron.down")
                // This modifier available for image since iOS 16.0
                    .fontWeight(.medium)
                    .foregroundColor(.black)
            }
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(.gray, lineWidth: 2)
        }
        .overlay (alignment: .top) {
            VStack {
                if self.isOptionsPresented {
                    Spacer(minLength: 60)
                    // Drop-down menu options list
                    DropdownMenuList(options: self.options) { option in
                        self.isOptionsPresented = false
                        self.selectedOption = option
                    }
                }
            }
        }
        .padding(.horizontal)
        .padding(
            // Check if options list is open or not
            .bottom, self.isOptionsPresented
            // If options list is open, then check if options size is greater
            // than 300 (MAX HEIGHT - CONSTANT), or not
            ? CGFloat(self.options.count * 32) > 300
            // IF true, then set padding to max height 3-- points
            ? 300 + 30 // max height + more padding to set space between borders
            // and text
            // if false, then calculate options size and set padding
            : CGFloat(self.options.count * 32) + 30
            // if option list is closed, then don't set any padding
            : 0
        )
    }
}

struct DropdownMenu_Previews: PreviewProvider {
    static var previews: some View {
        DropdownMenu(
            selectedOption: .constant(nil),
            placeholder: "Select your condition",
            options: DropdownMenuOption.testAllConditions
        )
    }
}
