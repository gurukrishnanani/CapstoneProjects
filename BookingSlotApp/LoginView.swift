//
//  LoginView.swift
//  BookingSlotApp
//
//  Created by admin on 15/02/25.
//

import SwiftUI
import CoreData

struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView { // Wrap the content in a NavigationView
            VStack {
                TextField("Email", text: $email)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                SecureField("Password", text: $password)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Login") {
                    loginUser()
                }
                .padding()

                // NavigationLink to RegisterView
                NavigationLink("Don't have an account? Register", destination: RegisterView())
                    .padding()
            }
            .padding()
            .navigationTitle("Login")
        }
    }

    private func loginUser() {
        // Check if both fields are filled
        guard !email.isEmpty, !password.isEmpty else {
            showAlert(message: "Please enter both email and password.")
            return
        }

        // Fetch user by email
        if let user = fetchUser(with: email) {
            // Check if the password matches
            if user.password == password {
                // Successful login
                showAlert(message: "Login successful!")
            } else {
                // Incorrect password
                showAlert(message: "Incorrect password.")
            }
        } else {
            // No user found with that email
            showAlert(message: "No account found with that email.")
        }
    }

    // Fetch an existing user by email
    private func fetchUser(with email: String) -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        do {
            let result = try viewContext.fetch(request)
            return result.first
        } catch {
            print("Error fetching user: \(error)")
            return nil
        }
    }

    // Function to show alert
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Login Status", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(alert, animated: true, completion: nil)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
