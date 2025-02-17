//
//  AddSlotView.swift
//  BookingSlotApp
//
//  Created by admin on 15/02/25.
//

import SwiftUI
import CoreData

struct AddSlotView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var status = "Available"

    var body: some View {
        VStack {
            DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                .padding()

            DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                .padding()

            Picker("Status", selection: $status) {
                Text("Available").tag("Available")
                Text("Booked").tag("Booked")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Button("Save Slot") {
                saveSlot()
            }
            .padding()
        }
        .padding()
        .navigationTitle("Add Slot")
    }

    private func saveSlot() {
        let newSlot = Slot(context: viewContext)
        newSlot.id = UUID()
        newSlot.startDate = startDate
        newSlot.endDate = endDate
        newSlot.status = status

        do {
            try viewContext.save()
        } catch {
            print("Error saving slot: \(error)")
        }
    }
}

struct AddSlotView_Previews: PreviewProvider {
    static var previews: some View {
        AddSlotView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
