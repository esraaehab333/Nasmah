//
//  CoreDataManager.swift
//  Nasmah
//
//  Created by Nemo on 05/06/2026.
//

import CoreData
import Foundation

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let context: NSManagedObjectContext
    
    private init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }
 
    func saveLocation(
        name: String,
        region: String = "",
        country: String = "",
        latitude: Double = 0.0,
        longitude: Double = 0.0
    ) {
        let entity = LocationEntity(context: context)
        entity.name = name
        entity.region = region
        entity.country = country
        entity.latitude = latitude
        entity.longitude = longitude
 
        do {
            try context.save()
        } catch {
            print("Failed to save location: \(error)")
        }
    }
 
    func fetchAllLocations() -> [LocationEntity] {
        let request = NSFetchRequest<LocationEntity>(entityName: "LocationEntity")
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch locations: \(error)")
            return []
        }
    }
    
    func deleteLocation(name: String) {
        let request = NSFetchRequest<LocationEntity>(entityName: "LocationEntity")
        request.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let results = try context.fetch(request)
            results.forEach { context.delete($0) }
            try context.save()
        } catch {
            print("Failed to delete location: \(error)")
        }
    }
}
