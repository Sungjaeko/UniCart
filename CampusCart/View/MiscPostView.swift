//
//  MiscPostView.swift
//  CampusCart
//
//  Created by Sung Jae Ko on 11/28/23.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage

struct MiscPostView: View {
    @EnvironmentObject var viewModel: MiscViewModel
    @StateObject private var authViewModel = AuthViewModel()
    @State var title: String = ""
    @State var description: String = ""
    
 
    @Binding var posts: [NoImageListing]
    @Binding var writing: Bool
    
    func submitArticle() {
        // We take a two-part approach here: this first part sends the article to
        // the database. The `createArticle` function gives us its ID.
        let postId = viewModel.createPost(miscPost: NoImageListing(
            id: UUID().uuidString, // Temporary, only here because Article requires it.
            title: title,
            description: description,
            date: Date()
        ))

        // As an optimization, instead of reloading all of the entries again, we
        // just _add a new Article in memory_. This makes things appear faster and
        // if the database creation worked fine, upon the next load we would then
        // get the real stored Article.
        //
        // There is some risk here—in the event of an error we might mistakenly
        // provide the wrong impression that the Article was stored when it actually
        // wasn’t. More sophisticated code can look at the published `error` variable
        // in the article service and provide some feedback if that error becomes
        // non-nil.
        posts.append(NoImageListing(
            id: postId,
            title: title,
            description: description,
            date: Date()
        ))

        writing = false
    }
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (alignment: .center) {
                    
//                    Text("Required")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .font(.system(size:30, weight: .bold, design: .rounded))
//                        .padding()
//
                    Text("Title")
                        .font(.system(size:20, weight: .bold, design: .rounded))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(14)
                    TextField("Title",text:$title)
                        .frame(width: .infinity)
                        .padding(14)
                        .overlay{
                            RoundedRectangle(cornerRadius: 9)
                                .stroke(.gray.opacity(0.6), lineWidth: 2)
                        }
                        .padding()
                    Text("Description")
                        .font(.system(size:20, weight: .bold, design: .rounded))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(14)
                    TextField("Description",text:$description).foregroundColor(.gray.opacity(0.9))
                        .frame(width: .infinity,height:150,alignment:.top)
                        .padding(14)
                        .overlay{
                            RoundedRectangle(cornerRadius: 9)
                                .stroke(.gray.opacity(0.6), lineWidth: 2)
                        }
                        .padding()
                    
                    Button("Submit"){
                        Task {
                            submitArticle()
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .background(.red)
                }
                
                
            }
            .navigationTitle("New Listing")
            .navigationBarTitleDisplayMode(.large)
            
        }
    }
}
    
    struct MiscPostView_Previews: PreviewProvider {
        @State static var posts: [NoImageListing] = []
        @State static var writing = true
        static var previews: some View {
            MiscPostView(posts: $posts, writing: $writing)
                .environmentObject(MiscViewModel())
        }
    }
