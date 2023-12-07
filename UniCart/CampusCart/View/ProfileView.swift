//
//  ProfileView.swift
//  CampusCart
//
//  Created by Bryan Apodaca on 10/3/23.
//

import SwiftUI

struct ProfileView: View {
    var user: User
    let navyBlue = Color(red: 0, green: 0, blue: 134, opacity: 1)
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    
                    Rectangle()
                        .fill(LinearGradient(colors: [.blue.opacity(0.4),.purple
                            .opacity(0.4)],startPoint: .topLeading,endPoint: .bottomTrailing))
                        .frame(height: 250, alignment: Alignment.top)
                    
                    
                    VStack {
                        ZStack {

                            Text(user.initials())
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                           
                        }
                        
                            
                        
//                        Text("\(firstName) \(lastName)")
//                            .font(.title)
//
//                        Text(email)
//                            .font(.subheadline)
//                            .foregroundColor(.gray)
                    }
                }
                SettingsBoxView(text: user.fullName(), boxName: "Full Name")
                SettingsBoxView(text: user.email, boxName: "Email Address")
                Spacer()
                
                HStack {
                    Button {
                        print("Sign out..")
                    } label: {
                        SettingsRowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: .red)
                            .padding()
                    }
                    .overlay{
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(.gray.opacity(0.6), lineWidth: 2)
                    }
              
                    Button {
                        print("Delete Account..")
                    } label: {
                        SettingsRowView(imageName: "person.crop.circle.fill.badge.xmark", title: "Delete Account", tintColor: .red)
                            .padding()
                    }
                    .overlay{
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(.gray.opacity(0.6), lineWidth: 2)
                    }
                    
                }
                
            }
        }
        .navigationTitle("Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User.MOCK_USER)
    }
}
