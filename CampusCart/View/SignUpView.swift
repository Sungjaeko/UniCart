//
//  SignUp.swift
//  CampusCart
//
//  Created by Sung Jae Ko on 10/1/23.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var showPassword: Bool = false
    @State var confirmPassword: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray
                    .opacity(0.12)
                    .ignoresSafeArea()
                VStack(alignment: .center, spacing: 15) {
                    Text("Logo")
                        .frame(maxWidth: .infinity, alignment: .center)
//                    Text("Create Account")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .font(.system(size: 35, weight: .heavy, design: .rounded))
//                        .padding(.bottom, 50)
                    Group {
                        Text("Hello!")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size:40, weight: .bold, design: .rounded))
                        
                        Text("Sign Up To")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size:40, weight: .regular, design: .rounded))
                        Text("Get Started")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size:40, weight: .regular, design: .rounded))
                    }
                    .padding(-1)
                    .padding(.horizontal, 20)
                    SignUpInputView(text: $firstName,
                                    title: "First Name",
                                    placeholder: "First Name")
                    .autocapitalization(.none)
                    .padding(11)
                    
                    .overlay{
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(.gray.opacity(0.6),lineWidth:2)
                    }
                    .padding(.horizontal)
                    
                    SignUpInputView(text: $lastName,
                                    title: "Last Name",
                                    placeholder: "Last Name")
                    .autocapitalization(.none)

                    .padding(11)
                    .overlay{
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(.gray.opacity(0.6),lineWidth:2)
                    }
                    .padding(.horizontal)
                    SignUpInputView(text: $email,
                                    title: "Email Address",
                                    placeholder: "Email Address")
                    .autocapitalization(.none)
                    .padding(11)
                    .overlay{
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(.gray.opacity(0.6),lineWidth:2)
                    }
                    
                    .padding(.horizontal)
                    SignUpInputView(text: $password,
                                    title: "Password",
                                    placeholder: "Password",
                                    isSecureField: true)
                    .padding(11)
                    .overlay{
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(.gray.opacity(0.6),lineWidth:2)
                    }
                    .padding(.horizontal)
                    ZStack(alignment: .trailing) {
                        SignUpInputView(text: $confirmPassword,
                                        title: "Confirm Password",
                                        placeholder: "Confirm Password",
                                        isSecureField: true)
                        .padding(11)
                        .overlay{
                            RoundedRectangle(cornerRadius: 22)
                                .stroke(.gray.opacity(0.6),lineWidth:2)
                        }
                        .padding(.horizontal)
                        if !password.isEmpty && !confirmPassword.isEmpty {
                            if password == confirmPassword {
                                Image(systemName: "checkmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemGreen))
                                    .padding(.horizontal, 30)
                            } else {
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemRed))
                                    .padding(.horizontal,30)
                            }
                        }
                    }
                    // if password and confirmPassword do not match, throw an error
                    NavigationLink(destination: LoginView()) {
                        Button {
                            Task {
                                try await viewModel.createUser(withEmail: email, firstName: firstName, lastName: lastName, password: password, confirmPassword: confirmPassword)
                            }
                        } label: {
                            Text("Sign up")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                        }
                    }
                        .frame(height:50)
                        .frame(maxWidth: 280)
                        .disabled(!formIsValid)
                        .opacity(formIsValid ? 1.0 : 0.5)
                        .background(Color.green.opacity(0.6))
                        .cornerRadius(20)
                    
                    NavigationLink {
                        LoginView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        HStack(spacing: 3) {
                            Text("Already have an account?")
                                .foregroundStyle(.black)
                            Text("Sign in")
                                .fontWeight(.bold)
                                .foregroundStyle(.green.opacity(0.8))
                        }
                        // .font(.system(size: 14))
                    }
                }
                .padding(.horizontal)
                .padding(.top, 12)
                //Spacer()
                
            }
        }
    }
}

// MARK: ~ AuthenticationFormProtocol

extension SignUpView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && email.contains(".edu")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !firstName.isEmpty
        && !lastName.isEmpty
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
