//
//  neumorphimTestApp.swift
//  neumorphimTest
//
//  Created by Freddy Haug on 1/28/21.
//

import SwiftUI

@main
struct neumorphimTestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
