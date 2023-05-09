//
//  DatabaseUtility.swift
//  PlanetListTask
//
//  Created by Prajakta on 09/05/23.
//

import Foundation
import CoreData
import UIKit
class DatabaseUtility {
    
    static var shared = DatabaseUtility()
    let managedContext = CoreDataStack().persistentContainer.viewContext

    /// Generic function to check data is avaiable in database for specific url

    func checkInDatabaseWith<T: Codable>(url: String,
                                         completionBlock: @escaping ((T?) -> Void)) {
        if let data = self.getDatabaseValuesFor(url: url) {
            completionBlock(try? JSONDecoder().decode(T.self, from: data))
        }
    }

    func getDatabaseValuesFor(url: String) -> Data? {
        let entries = self.getApiEntryFor(url: url)
        if entries.count > 0 {
            return entries[0].rawData
        }
        return nil
    }
    
    /// This function get values from database

    func getApiEntryFor(url: String) -> [PlanetOffline] {
        
        var planets = [PlanetOffline]()
        let fetchRequest: NSFetchRequest<PlanetOffline> = PlanetOffline.fetchRequest()
        do {
             planets = try managedContext.fetch(fetchRequest)
        } catch {
            print("Unable to fetch data, (\(error))")
        }
 
        planets = planets.filter({$0.url == url})
        return planets

    }
    
    /// This function add values to database

    func addValuesToDatabase(rawData: Data,
                             url: String) {

        let entries = self.getApiEntryFor(url: url)
        if entries.count == 1 { /// update entry if already available
            let entry = entries[0]
            entry.url = url
            entry.rawData = rawData
            entry.timeStamp = Date()
        } else if entries.count == 0 { /// add entry if not available
            let planet = PlanetOffline(context: managedContext)
            planet.rawData = rawData
            planet.url = url
            planet.timeStamp = Date()
        }

        do {
            try managedContext.save()
        }
        catch {
            print("Unable to add data, (\(error))")
        }
    }
}
