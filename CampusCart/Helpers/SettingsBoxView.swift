//
//  BubbleBoxView.swift
//  CampusCart
//
//  Created by Sung Jae Ko on 10/10/23.
//

import SwiftUI

struct SettingsBoxView: View {
    var text: String
    let boxName: String
    var isSecureField = false
    
    var body: some View {
        VStack (alignment: .leading, spacing: 12) {
            Text(boxName)
                .foregroundStyle(.gray.opacity(0.6))
                .fontWeight(.semibold)
                .fontDesign(.rounded)
                .font(.footnote)
            Text(text)
                .font(.system(size: 18, weight: .semibold, design: .rounded))
            Divider()
        }
        .padding(.vertical)
            .frame(width: 350)
    }
    
}

struct SettingsBoxView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsBoxView(text: "test@gmail.com", boxName: "Email")
    }
}
