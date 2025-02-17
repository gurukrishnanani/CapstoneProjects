//
//  LoginView.swift
//  SlotBookingApp
//
//  Created by admin on 17/02/25.
//
import SwiftUI
import CoreData

struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: User.entity(), sortDescriptors: []) private var users: FetchedResults<User>

    @State private var username = ""
    @State private var password = ""
    @State private var isAuthenticated = false
    @State private var showError = false // To track login errors

    var body: some View {
        if isAuthenticated {
            TechTrackDashboardView(isAuthenticated: $isAuthenticated) // Redirect to dashboard with binding
        } else {
            NavigationView {
                VStack {
                    Spacer()

                    Text("Welcome Back!")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.primary)
                        .padding(.bottom, 30)

                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)

                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)

                    if showError {
                        Text("Invalid username or password!")
                            .foregroundColor(.red)
                            .font(.subheadline)
                            .padding(.top, 5)
                    }

                    Button(action: {
                        authenticateUser(username: username, password: password)
                    }) {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .font(.headline)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                    .padding(.top, 20)

                    NavigationLink("Don't have an account? Register here", destination: RegisterView())
                        .padding(.top, 15)
                        .foregroundColor(.blue)

                    Spacer()
                }
                .padding()
                .background(Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all))
            }
        }
    }

    private func authenticateUser(username: String, password: String) {
        if let user = users.first(where: { $0.username == username && $0.password == password
            
        }) {
            // Successful login
            isAuthenticated = true
            showError = false // Clear error if login is successful
        } else {
            // Handle invalid login here
            showError = true // Show error if login fails
        }
    }
}
