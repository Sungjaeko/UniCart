//
//  HomeViewButtonView.swift
//  CampusCart
//
//  Created by Sung Jae Ko on 10/11/23.
//

import SwiftUI

struct HomeViewButtonView: View {
    let text: String
    let imageName: String
    @State var isHolding = true
    var body: some View {
        if isHolding {
            ZStack {
                Rectangle()
                    .fill(.white)
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.3), radius: 2, x:2, y:5)
                
                VStack {
                    Image(systemName: imageName)
                        .font(.title)
                        .foregroundStyle(LinearGradient(colors: [.pink.opacity(0.3),.red
                            .opacity(0.8)],startPoint: .topLeading,endPoint: .bottomTrailing))
                    Text(text)
                        .font(.body)
                        .foregroundStyle(.opacity(0.5))
                        .fontDesign(.rounded)
                        .foregroundStyle(.black)
                    
                    
                }
                .padding()
                
            }
        } else {
            ZStack {
                Rectangle()
                    .fill(LinearGradient(colors: [.pink.opacity(0.3),.red
                        .opacity(0.8)],startPoint: .topLeading,endPoint: .bottomTrailing))
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.3), radius: 2, x:2, y:5)
                
                VStack {
                    Image(systemName: imageName)
                        .font(.title)
                        .foregroundStyle(.white)
                    Text(text)
                        .font(.body)
                        .foregroundStyle(.white)
                        .fontDesign(.rounded)
                        .foregroundStyle(.black)
                    
                    
                }
                .padding()
                
            }
        }
    }
}

struct HomeViewButtonView_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewButtonView(text: "Items", imageName: "cart", isHolding: true)
    }
}

