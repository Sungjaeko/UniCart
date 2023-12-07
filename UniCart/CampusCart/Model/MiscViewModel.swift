import Foundation
import Firebase
import FirebaseFirestoreSwift

let COLLECTION_NAME = "miscellaneous"
let PAGE_LIMIT = 20

enum ArticleServiceError: Error {
    case mismatchedDocumentError
    case unexpectedError
}

class MiscViewModel: ObservableObject {
    private let db = Firestore.firestore()
    @Published var error: Error?
    @Published var posts: [NoImageListing] = []

    
    func createPost(miscPost: NoImageListing) -> String {
        var ref: DocumentReference? = nil
        
        // addDocument is one of those “odd” methods.
        ref = db.collection(COLLECTION_NAME).addDocument(data: [
            "title": miscPost.title,
            "date": miscPost.date, // This gets converted into a Firestore Timestamp.
            "description": miscPost.description
        ]) { possibleError in
            if let actualError = possibleError {
                self.error = actualError
            }
        }
        print("IT PASSED")
        // If we don’t get a ref back, return an empty string to indicate “no ID.”
        return ref?.documentID ?? ""
    }
    
    func fetchPosts() async throws -> [NoImageListing] {
        let postQuery = db.collection(COLLECTION_NAME)
            .order(by: "date", descending: true)
            .limit(to: PAGE_LIMIT)
        
        // Fortunately, getDocuments does have an async version.
        //
        // Firestore calls query results “snapshots” because they represent a…wait for it…
        // _snapshot_ of the data at the time that the query was made. (i.e., the content
        // of the database may change after the query but you won’t see those changes here)
        let querySnapshot = try await postQuery.getDocuments()
        print("You've Made it here 1")
        return try querySnapshot.documents.map {
            // This is likely new Swift for you: type conversion is conditional, so they
            // must be guarded in case they fail.
            print("You've Made it here 2")
            guard let title = $0.get("title") as? String,
                  // Firestore returns Swift Dates as its own Timestamp data type.
                  let dateAsTimestamp = $0.get("date") as? Timestamp,
                  let description = $0.get("description") as? String else {
                throw ArticleServiceError.mismatchedDocumentError
            }
            print("You've Made it here 3")
            return NoImageListing(
                id: $0.documentID,
                title: title,
                description: description,
                date: dateAsTimestamp.dateValue()
            )
        }
    }
    
    func fetchData() {
        Task {
            do {
                let snapshot = try await db.collection(COLLECTION_NAME).getDocuments()
                posts = try snapshot.documents.compactMap {
                    try $0.data(as: NoImageListing.self)
                }
            } catch {
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
    }
    
    
}
