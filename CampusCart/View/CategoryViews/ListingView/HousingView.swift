

import SwiftUI
import Combine
import Firebase
import FirebaseStorage


struct HousingView: View {
    @State private var searchText: String = ""
    @StateObject var sharedData = ImagesList.shared
    @StateObject var itemListings = HousingListing.sharedListings
    
    var filteredListings: [HousingListing] {
        if searchText.isEmpty {
            return itemListings.listings
        } else {
            return itemListings.listings.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationView{
            ScrollView {
                ZStack {
                    Rectangle()
                        .fill(.white)
                        .frame(height: 60)
                        .cornerRadius(10)
                        .shadow(radius: 3, x:2, y: 3)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .padding()
                        TextField("Search", text: $searchText, prompt: Text("Search")
                            .foregroundColor(.gray.opacity(0.9)))
                    }
                }
                .padding()
                VStack(alignment: .leading){
                    
                    NavigationLink(destination: HousingPostView()){
                        Text("New Post")
                    }
                    .padding()
                    VStack (alignment: .leading){
                        ForEach(itemListings.listings, id: \.self) { listing in
                            HStack(alignment: .top){
                                ForEach(listing.img, id: \.self) {image in
                                    
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width:130,height:130)
                                        .cornerRadius(13)
                                }
                                
                                VStack (alignment: .leading){
                                    Text(listing.title)
                                        .font(.system(size:20, weight: .regular, design: .rounded))
                                    Text("$\(String(listing.price))")
                                        .font(.system(size:20, weight: .bold, design: .rounded))
                                }
                                
                            }
                            .padding()
                            Divider()
                        }
                    }
                    .navigationBarTitle("Items")
                    Spacer()
                }
                
            }
        }
    }
}



struct HousingView_Previews: PreviewProvider {
    static var previews: some View {
        HousingView()
    }
}
