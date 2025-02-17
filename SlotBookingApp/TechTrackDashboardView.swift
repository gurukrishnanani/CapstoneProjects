//
//  TechTrackDashboardView.swift
//  SlotBookingApp
//
//  Created by admin on 17/02/25.
//
import SwiftUI

struct TechTrackDashboardView: View {
    @FetchRequest(
        entity: TechTrack.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \TechTrack.name, ascending: true)]
    ) var techTracks: FetchedResults<TechTrack>

    @Environment(\.managedObjectContext) private var viewContext

    @Binding var isAuthenticated: Bool // Use binding for logout

    @State private var newTechTrackName = "" // State to hold new tech track name
    @State private var showError = false // Show error if tech track name is empty

    var body: some View {
        NavigationView {
            VStack {
                // Header section
                Text("Tech Track Dashboard")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.primary)
                    .padding(.top, 20)

                // List of tech tracks
                List {
                    ForEach(techTracks, id: \.self) { techTrack in
                        NavigationLink(destination: SlotListView(techTrack: techTrack)) {
                            HStack {
                                Text(techTrack.name ?? "Unknown Tech Track")
                                    .font(.headline)
                                    .padding(.vertical, 10)
                                Spacer()
                                Image(systemName: "chevron.right.circle.fill")
                                    .foregroundColor(.blue)
                            }
                            .padding(.horizontal)
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                deleteTechTrack(techTrack)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                    .listRowBackground(Color.white)
                }
                .listStyle(PlainListStyle())
                .cornerRadius(10)
                .shadow(radius: 5)

                // Add new tech track section
                VStack {
                    TextField("Enter New Tech Track", text: $newTechTrackName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)

                    if showError {
                        Text("Tech Track name cannot be empty!")
                            .foregroundColor(.red)
                            .font(.subheadline)
                            .padding(.bottom, 10)
                    }

                    Button(action: addTechTrack) {
                        Text("Add Tech Track")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .font(.headline)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                    .padding(.top, 10)
                }
                .padding(.horizontal)

                Spacer()

                // Logout button
                Button(action: {
                    isAuthenticated = false // Simulate logout
                }) {
                    Text("Logout")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .font(.headline)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .padding()
            .background(Color.gray.opacity(0.05).edgesIgnoringSafeArea(.all))
        }
    }

    // Add new Tech Track
    private func addTechTrack() {
        if newTechTrackName.isEmpty {
            showError = true // Show error if input is empty
        } else {
            let newTechTrack = TechTrack(context: viewContext)
            newTechTrack.name = newTechTrackName
            saveContext()
            newTechTrackName = "" // Clear input after adding
            showError = false // Clear error after successful addition
        }
    }

    // Delete Tech Track
    private func deleteTechTrack(_ techTrack: TechTrack) {
        viewContext.delete(techTrack)
        saveContext() // Save after deletion
    }

    // Save context to persist changes in Core Data
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving Core Data: \(error)")
        }
    }
}

struct TechTrackDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        TechTrackDashboardView(isAuthenticated: .constant(true))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
