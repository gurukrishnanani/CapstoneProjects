//
//  RegisterView.swift
//  SlotBookingApp
//
//  Created by admin on 17/02/25.
//
import SwiftUI

struct RegisterView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var username = ""
    @State private var password = ""
    @State private var registrationSuccess = false

    var body: some View {
        VStack {
            Spacer()

            Text("Create Account")
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

            Button(action: {
                registerUser()
            }) {
                Text("Register")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .font(.headline)
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }
            .padding(.top, 20)

            if registrationSuccess {
                Text("Registration successful!")
                    .foregroundColor(.green)
                    .font(.subheadline)
                    .padding(.top, 10)
            }

            Spacer()

            NavigationLink("Already have an account? Login here", destination: LoginView())
                .padding(.top, 15)
                .foregroundColor(.blue)

        }
        .padding()
        .background(Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all))
    }

    private func registerUser() {
        let newUser = User(context: viewContext)
        newUser.username = username
        newUser.password = password

        do {
            try viewContext.save()
            registrationSuccess = true
        } catch {
            print("Failed to register user: \(error)")
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
