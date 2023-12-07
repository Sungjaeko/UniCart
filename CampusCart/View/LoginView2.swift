//
//  LoginView2.swift
//  CampusCart
//
//  Created by Sung Jae Ko on 11/29/23.
//

import SwiftUI

struct LoginView2: View {
    @State private var isLogged = false
    @State var email: String = ""
    @State var password: String = ""
    @State var showPassword: Bool = false
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        NavigationStack {
            VStack {
                Text("UniCart")
                    .font(.system(size:40, weight: .medium, design: .monospaced))
                    .foregroundStyle(.red.opacity(0.6))
                    //.padding(.vertical, 50)
                Spacer()
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                TextField("Email", text: $email)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.06))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(wrongUsername))
                SecureField("Password", text: $password)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.06))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(wrongPassword))
                
                Button{
                    Task {
                        try await viewModel.login(withEmail: email, password: password)
                        isLogged = true
                    }
                } label:{
                    Text("Login")
                        
                }
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(.red.opacity(0.8))
                .cornerRadius(10)
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                
                NavigationLink {
                    SignUpView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                            .foregroundStyle(.black)
                        Text("Sign up")
                            .fontWeight(.bold)
                            .foregroundStyle(.red.opacity(0.8))
                    }
                    
                }
                NavigationLink (destination: MainView(), isActive: $isLogged, label: {
                    EmptyView()
                })
                .hidden()
                Spacer()
            }
        }
    }
}

// MARK: ~ AuthenticationFormProtocol

extension LoginView2: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && email.contains(".edu")
        && !password.isEmpty
        && password.count > 5
    }
}

struct LoginView2_Previews: PreviewProvider {
    static var previews: some View {
        LoginView2()
    }
}

