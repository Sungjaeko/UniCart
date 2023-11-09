//
//  PostView.swift
//  CampusCart
//
//  Created by Bryan Apodaca on 10/3/23.
//

import SwiftUI
import PhotosUI
import Firebase

//@MainActor
//final class PhotoPickerViewModel: ObservableObject{
//
//    @Published private(set) var selectedImage: UIImage? = nil
//    @Published var imageSelection: PhotosPickerItem? = nil{
//        didSet{
//            setImage(from: imageSelection)
//        }
//    }
//
//    @Published private(set) var selectedImages: [UIImage] = []
//    @Published var imageSelections: [PhotosPickerItem] = [] {
//        didSet{
//            setImages(from: imageSelections)
//        }
//    }
//
//    private func setImage(from selection: PhotosPickerItem?){
//        guard let selection else {return}
//
//        Task{
//            //            if let data = try? await selection.loadTransferable(type: Data.self){
//            //                if let uiImage = UIImage(data: data){
//            //                    selectedImage = uiImage
//            //                    return
//            //                }
//            //            }
//            do {
//                let data = try? await selection.loadTransferable(type: Data.self)
//
//                guard let data, let uiImage = UIImage(data: data) else {
//                    throw URLError(.badServerResponse)
//                }
//
//                selectedImage = uiImage
//            } catch {
//                print(error)
//            }
//        }
//
//    }
//
//    private func setImages(from selections: [PhotosPickerItem]) {
//        Task {
//            var images: [UIImage] = []
//            for selection in selections {
//                if let data = try? await selection.loadTransferable(type: Data.self){
//                    if let uiImage = UIImage(data: data){
//                        images.append(uiImage)
//
//                    }
//                }
//            }
//            selectedImages = images
//        }
//
//    }
//
//}



struct PostView: View {
    //@Binding var listings: [ImageListing]
    let db = Firestore.firestore()
    @StateObject var photoViewModel = PhotoPickerViewModel()
    @StateObject private var viewModel = PostViewModel()
    @State private var condition: DropdownMenuOption? = nil
    @State var itemName: String = ""
    @State var description: String = ""
    @State var price: Int = 0
    //@State var condition = ["New", "Used - Like New", "Used - Good", "Used - Fair"]
    //@State var imageUploaded: Bool = true
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedItems: [PhotosPickerItem] = []
    @StateObject private var newListing = ImgListing()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
        
    var body: some View {
        NavigationView {
            
            ScrollView {
                VStack (alignment: .center) {
                    
                    if !photoViewModel.selectedImages.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack{
                                ForEach(photoViewModel.selectedImages, id: \.self) { image in
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width:200,height:200)
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                    else{
                        Text("No Images to show")
                    }
                    
                    PhotosPicker(selection: $photoViewModel.imageSelections, matching: .images, photoLibrary: .shared()){
                        Text("Select photos")
                    }
                    
                    
                    Text("Required")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size:30, weight: .bold, design: .rounded))
                        .padding()
                    
                    TextField("Title",text:$itemName)
                        .frame(width: .infinity)
                        .padding(14)
                        .overlay{
                            RoundedRectangle(cornerRadius: 9)
                                .stroke(.gray.opacity(0.6), lineWidth: 2)
                        }
                        .padding()
                    DropdownMenu(
                        selectedOption: self.$condition,
                        placeholder: "Select your condition",
                        options: DropdownMenuOption.testAllConditions)
                    TextField("Price",value: $price, format:.number)
                        .frame(width: .infinity)
                        .padding(14)
                        .overlay{
                            RoundedRectangle(cornerRadius: 9)
                                .stroke(.gray.opacity(0.6), lineWidth: 2)
                        }
                        .padding()
                    TextField("Description",text:$description).foregroundColor(.gray.opacity(0.9))
                        .frame(width: .infinity,height:150,alignment:.top)
                        .padding(14)
                        .overlay{
                            RoundedRectangle(cornerRadius: 9)
                                .stroke(.gray.opacity(0.6), lineWidth: 2)
                        }
                        .padding()
                    Button {
                        
                        let randomId = randomString(length: 10)
                        newListing.id = randomId
                        newListing.title = itemName
                        newListing.description = description
                        newListing.price = price
                        newListing.condition = condition?.option ?? "No Condition"
                        let collectionReference = db.collection("listings")
                        collectionReference.addDocument(data:[
                            "id": newListing.id,
                            "title": newListing.title,
                            "description": newListing.description,
                            "price": newListing.price,
                            "condition": newListing.condition])
                        self.presentationMode.wrappedValue.dismiss()
                        
                    } label: {
                        Text("Submit")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                    }
                    .frame(height:50)
                    .frame(maxWidth: 300)
                    .background(Color.blue)
                        //                .background(
                        //                    LinearGradient(colors: [.red,.blue],startPoint: .topLeading,endPoint: .bottomTrailing)
                        //                )
                    .cornerRadius(9)
                    .shadow(radius: 4 , x: 2, y: 3)
                    .onChange(of: photoViewModel.imageSelections, perform: {newValues in
                            viewModel.savePostImages(items: newValues)
                            
                    })
                    .padding()
                    
                }
            }
            .navigationTitle("New Listing")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    func randomString(length: Int) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""
        
        for _ in 0..<length {
            let randomIndex = Int.random(in: 0..<characters.count)
            let character = characters[characters.index(characters.startIndex, offsetBy: randomIndex)]
            randomString.append(character)
        }
        
        return randomString
    }
}

struct PostView_Previews: PreviewProvider {
    @State static var listings: [ImageListing] = []
    static var previews: some View {
        PostView()
            .environmentObject(PhotoPickerViewModel())
            .environmentObject(ImgListing())
    }
}
