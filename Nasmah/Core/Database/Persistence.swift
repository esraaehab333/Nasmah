//
//  Persistence.swift
//  Nasmah
//
//  Created by Nemo on 05/06/2026.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Nasmah")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Core Data failed to load: \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
