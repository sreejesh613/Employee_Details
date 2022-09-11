//
//  DatabaseController.swift
//  Employee Details
//
//  Created by Sreejesh Krishnan on 11/09/22.
//

import Foundation
import CoreData

class DatabaseController {
    private init() {}
    
    //Returns the current Persistent Container for CoreData
    class func getContext () -> NSManagedObjectContext {
        return DatabaseController.persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        //The container that holds both data model entities
        let container = NSPersistentContainer(name: "Employee_Details")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
            
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    class func saveContext() {
        let context = self.getContext()
//        if context.hasChanges {
            do {
                try context.save()
                print("Data Saved to Context")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
//        }
    }
    
        // GET / Fetch / Requests
            class func getAllUsers() -> Array<Users> {
                let all = NSFetchRequest<Users>(entityName: "Users")
                var allUsers = [Users]()
    
                do {
                    let fetched = try DatabaseController.getContext().fetch(all)
                    allUsers = fetched
                } catch {
                    let nserror = error as NSError
                    //TODO: Handle Error
                    print(nserror.description)
                }
    
                return allUsers
            }
    
    //        // Get Show by uuid
    //        class func getShowWith(uuid: String) -> ShowModel? {
    //            let requested = NSFetchRequest<ShowModel>(entityName: "ShowModel")
    //            requested.predicate = NSPredicate(format: "uuid == %@", uuid)
    //
    //            do {
    //                let fetched = try DatabaseController.getContext().fetch(requested)
    //
    //                //fetched is an array we need to convert it to a single object
    //                if (fetched.count > 1) {
    //                    //TODO: handle duplicate records
    //                } else {
    //                    return fetched.first //only use the first object..
    //                }
    //            } catch {
    //                let nserror = error as NSError
    //                //TODO: Handle error
    //                print(nserror.description)
    //            }
    //
    //            return nil
    //        }
}
