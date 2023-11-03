//
//  SignUpInputView.swift
//  CampusCart
//
//  Created by Sung Jae Ko on 10/2/23.
//

import SwiftUI

struct SignUpInputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
            } else {
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
                    .foregroundStyle(.gray.opacity(0.9))
            }
           
        }
    }
}

struct SignUpInputView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpInputView(text: .constant(""), title: "Email Address", placeholder: "name@example.com")
    }
}
