//
//  PersistenceController.swift
//  BookingSlotApp
//
//  Created by admin on 15/02/25.
//

import Foundation
import CoreData

// This class is responsible for managing the Core Data stack.
class PersistenceController {
    static let shared = PersistenceController()

    // The container that holds the Core Data stack
    let container: NSPersistentContainer

    // Initializer to set up Core Data stack
    init(inMemory: Bool = false) {
        // The name should match your .xcdatamodeld file
        container = NSPersistentContainer(name: "BookingSlotApp")

        // Use an in-memory store for testing purposes
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        // Load the persistent stores
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    // This function is used to save data to Core Data
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
