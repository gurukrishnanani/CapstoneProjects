//
//  SlotBookingAppApp.swift
//  SlotBookingApp
//
//  Created by admin on 17/02/25.
//

import SwiftUI

@main

struct SlotBookingAppApp: App {
    let persistenController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,persistenController.container.viewContext)
        }
    }
}
