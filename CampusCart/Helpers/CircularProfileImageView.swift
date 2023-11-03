//
//  CircularProfileImageView.swift
//  CampusCart
//
//  Created by Sung Jae Ko on 10/29/23.
//

import SwiftUI
import Kingfisher

struct CircularProfileImageView: View {
    let user: User
    var body: some View {
        if let imageUrl = user.profileImageUrl {
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 80,height: 80)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 80,height: 80)
                .clipShape(Circle())
        }
    }
}

struct CircularProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProfileImageView(user: User.MOCK_USER)
    }
}
