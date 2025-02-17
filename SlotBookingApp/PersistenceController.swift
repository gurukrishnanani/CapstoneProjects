//
//  PersistenceController.swift
//  SlotBookingApp
//
//  Created by admin on 15/02/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        // Create sample user for preview
        let newUser = User(context: viewContext)
        newUser.username = "testuser"
        newUser.password = "password"

        do {
            try viewContext.save()
        } catch {
            fatalError("Unresolved error \(error)")
        }

        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "SlotBookingApp")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
