//
//  MiscView.swift
//  CampusCart
//
//  Created by Bryan Apodaca on 10/18/23.
//

import SwiftUI

struct SidejobsView: View {
    @State private var searchText: String = ""
    @EnvironmentObject var auth: AuthViewModel
    @EnvironmentObject var viewModel: SideJobViewModel
    
    @State var posts: [NoImageListing]
    @State var error: Error?
    @State var fetching = false
    
    var body: some View {
        NavigationView {
            if fetching {
                ProgressView()
            } else if error != nil {
                
                Text("Something went wrong…we wish we can say more 🤷🏽")
            } else if posts.count == 0 {
                VStack {
                    Spacer()
                    Text("There are no listings.")
                    Spacer()
                }
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        NavigationLink(destination: SideJobPostView(posts: $posts)){
                            Text("New Post")
                        }
                    }
                    
                }
            } else {
                VStack {
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
                    
                    List(posts) { post in
                        HStack {
                            Text(post.title)
                            Spacer()
                            Text(post.date, style: .date)
                                .font(.caption)
                        }
                    }
                }
                .navigationBarTitle("Side Jobs")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        NavigationLink(destination: SideJobPostView(posts: $posts)){
                            Text("New Post")
                        }
                    }
                    
                }
            }
            Spacer()
        }
        .onAppear {
            fetchData()
        }
    }
    func fetchData() {
        Task {
            do {
                posts = try await viewModel.fetchPosts()
            } catch {
                self.error = error
            }
        }
    }
}
struct SidejobsView_Previews: PreviewProvider {
    static var previews: some View {
        SidejobsView(posts: [
            NoImageListing(
                id: "12345", title: "Looking for a helper", description: "Volunteering event", date: Date()),
            NoImageListing(
                id: "54321", title: "Looking for a ", description: "Volunteering event", date: Date())
        ])
        .environmentObject(SideJobViewModel())
    }
}
