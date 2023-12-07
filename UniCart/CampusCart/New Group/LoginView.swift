//
//  LoginScreen.swift
//  CampusCart
//
//  Created by Bryan Apodaca on 9/27/23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var isLogged = false
    @State var email: String = ""
    @State var password: String = ""
    @State var showPassword: Bool = false
    @StateObject var viewModel = AuthViewModel()
    let color = UIColor(red: 0.96, green: 0.54, blue: 0.10, alpha: 1.0)
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray
                    .opacity(0.12)
                    .ignoresSafeArea()
                
                
                VStack(alignment: .center, spacing: 15){
                    //                Image("CampusCart_Title")
                    //                    .resizable()
                    //                    .frame(width:350,height:250,alignment: .leading)
                    //                    .padding(.horizontal)
                    HStack {
                        Text("UniCart")
                            .font(.system(size:40, weight: .medium, design: .monospaced))
                            .foregroundStyle(.green.opacity(0.6))
                    }
                    .padding(25)
                    
                    Group {
                        Text("Hello!")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size:40, weight: .bold, design: .rounded))
                        
                        Text("Welcome")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size:40, weight: .regular, design: .rounded))
                        Text("Back")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size:40, weight: .regular, design: .rounded))
                    }
                    .padding(-1)
                    .padding(.horizontal, 40)
                    //                    Text("Login")
                    //                        .font(.system(size:30, weight: .medium, design: .rounded))
                    TextField("Email", text: $email,
                              prompt: Text("Email").foregroundColor(.gray.opacity(0.9)))
                    .frame(width: 320)
                    .padding(14)
                    .overlay{
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(.gray.opacity(0.6), lineWidth: 2)
                    }
                    .padding(12)
                    HStack{
                        
                        if showPassword {
                            TextField("Password",text: $password,prompt: Text("Password").foregroundColor(.blue))
                        }
                        else{
                            SecureField("Password",text:$password,prompt: Text("Password").foregroundColor(.gray.opacity(0.9)))
                        }
                        
                        Button{
                            showPassword.toggle()
                        }label:{
                            Image(systemName: showPassword ? "eye.slash" : "eye")
                                .foregroundColor(.gray.opacity(0.9)
                                )
                        }
                        
                    }
                    .frame(width: 320)
                    .padding(14)
                    .overlay{
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(.gray.opacity(0.6),lineWidth:2)
                    }
                    .padding(.horizontal)
                    
                    NavigationLink {
                        SignUpView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        HStack(spacing: 3) {
                            Text("Don't have an account?")
                                .foregroundStyle(.black)
                            Text("Sign up")
                                .fontWeight(.bold)
                                .foregroundStyle(.green.opacity(0.8))
                        }
                        
                    }
                    NavigationLink (destination: MainView(), isActive: $isLogged, label: {
                        EmptyView()
                    })
                    .hidden()
                    
                    Button{
                        Task {
                            try await viewModel.login(withEmail: email, password: password)
                            isLogged = true
                        }
                    }
                
                label:{
                    Text("Login")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                }
                .frame(height:50)
                .frame(maxWidth: 280)
                .background(Color.green.opacity(0.6))
                    //                .background(
                    //                    LinearGradient(colors: [.red,.blue],startPoint: .topLeading,endPoint: .bottomTrailing)
                    //                )
                .cornerRadius(20)
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .shadow(radius: 4 , x: 2, y: 3)
                .padding()
                    Spacer()
                    /*
                    NavigationLink(destination: MainView()){
                    Text("Bypass Login")
                }*/
                    
                }
            }
        }
    }
}
// MARK: ~ AuthenticationFormProtocol

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && email.contains(".edu")
        && !password.isEmpty
        && password.count > 5
    }
}
                          
struct LoginScreen_Previews: PreviewProvider {
            static var previews: some View {
                LoginView()
            }
        }
