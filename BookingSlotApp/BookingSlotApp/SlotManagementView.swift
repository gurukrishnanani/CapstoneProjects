//
//  SlotManagementView.swift
//  BookingSlotApp
//
//  Created by admin on 15/02/25.
//
import SwiftUI

struct SlotManagementView: View {
    @State private var slots: [String] = []
    @State private var newSlot: String = ""
    @State private var selectedSlot: String? = nil
    @State private var editedSlot: String = ""

    var body: some View {
        VStack {
            Text("Manage Your Availability")
                .font(.title)
                .padding()

            TextField("Add a new slot (e.g., Mon 10:00 AM)", text: $newSlot)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Add Slot") {
                if !newSlot.isEmpty {
                    slots.append(newSlot)
                    newSlot = ""
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.bottom)

            // Slot List with delete functionality
            List {
                ForEach(slots, id: \.self) { slot in
                    HStack {
                        Text(slot)
                            .onTapGesture {
                                self.selectedSlot = slot
                                self.editedSlot = slot
                            }
                        Spacer()
                        Button(action: {
                            removeSlot(slot)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
                .onDelete(perform: deleteSlot) // Corrected delete action
            }

            // Edit Section
            if let selectedSlot = selectedSlot {
                Text("Edit Slot: \(selectedSlot)")
                    .font(.headline)
                    .padding()

                TextField("Edit Slot", text: $editedSlot)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Update Slot") {
                    if let index = slots.firstIndex(of: selectedSlot) {
                        slots[index] = editedSlot
                        self.selectedSlot = nil
                        self.editedSlot = ""
                    }
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }

            Button("Save Slots") {
                saveSlots()
            }
            .padding()
            .background(Color.purple)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .navigationTitle("Slot Management")
    }

    private func removeSlot(_ slot: String) {
        if let index = slots.firstIndex(of: slot) {
            slots.remove(at: index)
        }
    }

    private func deleteSlot(at offsets: IndexSet) {
        slots.remove(atOffsets: offsets) // Correct use of IndexSet for deletion
    }

    private func saveSlots() {
        // Implement your Core Data saving logic here
        print("Slots Saved: \(slots)")
    }
}

struct SlotManagementView_Previews: PreviewProvider {
    static var previews: some View {
        SlotManagementView()
    }
}
