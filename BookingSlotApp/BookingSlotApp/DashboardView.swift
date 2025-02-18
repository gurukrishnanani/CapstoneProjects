//
//  DashboardView.swift
//  BookingSlotApp
//
//  Created by admin on 15/02/25.
//
import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to the Dashboard")
                    .font(.largeTitle)
                    .padding()

                // Navigate to Register View
                NavigationLink(destination: RegisterView()) {
                    Text("Register")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.bottom)
                }

                // Navigate to Login View
                NavigationLink(destination: LoginView()) {
                    Text("Login")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.bottom)
                }

                // Navigate to Tech Track Selection
                NavigationLink(destination: TechTrackSelectionView()) {
                    Text("Select Tech Track")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.bottom)
                }

                // Navigate to Slot Management
                NavigationLink(destination: SlotManagementView()) {
                    Text("Manage Slots")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.bottom)
                }

            }
            .padding()
            .navigationTitle("Dashboard")
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
