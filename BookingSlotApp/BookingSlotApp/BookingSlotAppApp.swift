//
//  BookingSlotAppApp.swift
//  BookingSlotApp
//
//  Created by admin on 15/02/25.
//

import SwiftUI

@main
struct BookingSlotAppApp: App {
    
 let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
    DashboardView()
        .environment(\.managedObjectContext,persistenceController.container.viewContext )
            
        }
    }
}
