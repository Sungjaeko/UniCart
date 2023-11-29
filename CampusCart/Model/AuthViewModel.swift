//
//  LoginViewModel.swift
//  CampusCart
//
//  Created by Sung Jae Ko on 10/2/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import SwiftUI

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var isLoggedIn = false
    let mockUser = User.MOCK_USER
    @State private var alertMessage = ""
    @State private var showAlert = false
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    
    
    func login(withEmail email: String, password: String) async throws {
        print("Sign in...")
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed to log in with error  \(error.localizedDescription)")
        }
    }
        
    func createUser(withEmail email: String, firstName: String, lastName: String, password: String, confirmPassword: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, firstName: firstName, lastName: lastName, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            do {
                try await Auth.auth().currentUser?.sendEmailVerification()
                print("Email verification sent")
            } catch {
                print("Error sending email verification: \(error.localizedDescription)")
            }
             
            
            // Check to see if user has verified their email, if so, fetch user else print error
            await fetchUser()
                
           
            
        } catch {
            print("DEBUG: Failed to create user with error  \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Failed to sign out with error  \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        let user = Auth.auth().currentUser
        
        user?.delete { error in
            if let error = error {
                print("Error deleting user: \(error.localizedDescription)")
            } else {
                print("User has been deleted")
            }
        }
        // self.userSession = nil
        // self.currentUser = nil
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)

        print("DEBUG: Current user is \(self.currentUser)")
    }
    
    func passwordReset(withEmail email: String) {
        if email != "" {
            Auth.auth().sendPasswordReset(withEmail: email) { err in
                if let err = err {
                    print("Error resetting password: \(err.localizedDescription)")
                } else {
                    print("Password has been reset")
                }
            }
        }
    }
}
