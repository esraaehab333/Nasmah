//
//  NasmahApp.swift
//  Nasmah
//
//  Created by Nemo on 05/06/2026.
//

import SwiftUI

@main
struct NasmahApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
