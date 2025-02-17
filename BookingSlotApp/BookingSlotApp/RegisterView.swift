//
//  RegisterView.swift
//  BookingSlotApp
//
//  Created by admin on 15/02/25.
//

import SwiftUI
import CoreData

struct RegisterView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var techTrack = ""

    var body: some View {
        VStack {
            TextField("Full Name", text: $name)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Email", text: $email)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Password", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Confirm Password", text: $confirmPassword)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Tech Track (e.g., iOS, Android)", text: $techTrack)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Register") {
                registerUser()
            }
            .padding()
        }
        .padding()
        .navigationTitle("Register")
    }

    private func registerUser() {
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty, !techTrack.isEmpty else {
            showAlert(message: "All fields are required.")
            return
        }

        guard password == confirmPassword else {
            showAlert(message: "Passwords do not match.")
            return
        }

        // Proceed with CoreData saving logic as defined in your PersistenceController
        let existingUser = fetchUser(with: email)
        if existingUser == nil {
            let newUser = User(context: viewContext)
            newUser.id = UUID()
            newUser.name = name
            newUser.email = email
            newUser.password = password
            newUser.techTrack = techTrack
            saveContext()
            showAlert(message: "Registration successful. Please login.")
        } else {
            showAlert(message: "Email already exists.")
        }
    }

    private func fetchUser(with email: String) -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        do {
            let result = try viewContext.fetch(request)
            return result.first
        } catch {
            return nil
        }
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Registration Status", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(alert, animated: true, completion: nil)
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
