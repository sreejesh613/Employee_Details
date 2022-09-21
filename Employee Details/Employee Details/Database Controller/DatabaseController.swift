//
//  DatabaseController.swift
//  Employee Details
//
//  Created by Sreejesh Krishnan on 11/09/22.
//

import Foundation
import CoreData
import UIKit

enum RecordStatus: Int {
    case notExist = 0
    case exists
    case unknown
}

class DatabaseController {
    
    private var viewContext: NSManagedObjectContext!
    
    static let shared = DatabaseController()
    
    init() {
        viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func add<T: NSManagedObject>(_ type: T.Type) -> T? {
        guard let entityName = T.entity().name else { return nil }
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: viewContext) else { return nil }
        let object = T(entity: entity, insertInto: viewContext)
        return object
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetch<T: NSManagedObject>(_ type: T.Type) -> [T] {
        
        let request = T.fetchRequest()
        do {
            let result = try viewContext.fetch(request)
            return result as! [T]
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func checkIfDataAlreadyExists(email: String, name: String) -> RecordStatus {

        let fetchRequest: NSFetchRequest<Users> = Users.fetchRequest()

        let identifierPredicate = NSPredicate(format: "email == %@", email)
        let namePredicate = NSPredicate(format: "name == %@", name)
        let compundPredicate = NSCompoundPredicate(type: .and, subpredicates: [identifierPredicate, namePredicate])
        fetchRequest.predicate = compundPredicate
                
        do {
            let arrData = try viewContext.fetch(fetchRequest)
            
            if arrData.count > 0 {
                return .exists
            } else {
                return .notExist
            }
        } catch {
            print(error.localizedDescription)
        }
        return .unknown
    }
    
    func getPredicatedUsers(for id: Int16) -> Users? {

        let fetchRequest: NSFetchRequest<Users> = Users.fetchRequest()

        let identifierPredicate = NSPredicate(format: "id == %i", id)
        fetchRequest.predicate = identifierPredicate
                
        do {
            let arrData = try viewContext.fetch(fetchRequest)
            
            if arrData.count > 0 {
                return arrData.first
            } else {
                return nil
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func getPredicatedCompany(for id: Int16) -> Company? {

        let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()

        let identifierPredicate = NSPredicate(format: "id == %i", id)
        fetchRequest.predicate = identifierPredicate
                
        do {
            let arrData = try viewContext.fetch(fetchRequest)
            
            if arrData.count > 0 {
                return arrData.first
            } else {
                return nil
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func getPredicatedAddress(for id: Int16) -> Address? {

        let fetchRequest: NSFetchRequest<Address> = Address.fetchRequest()

        let identifierPredicate = NSPredicate(format: "id == %i", id)
        fetchRequest.predicate = identifierPredicate
                
        do {
            let arrData = try viewContext.fetch(fetchRequest)
            
            if arrData.count > 0 {
                return arrData.first
            } else {
                return nil
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func getPredicatedGeo(for id: Int16) -> Geo? {

        let fetchRequest: NSFetchRequest<Geo> = Geo.fetchRequest()

        let identifierPredicate = NSPredicate(format: "id == %i", id)
        fetchRequest.predicate = identifierPredicate
                
        do {
            let arrData = try viewContext.fetch(fetchRequest)
            
            if arrData.count > 0 {
                return arrData.first
            } else {
                return nil
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}

//MARK: GENERIC METHOD FOR FETCHING
extension DatabaseController {
    func fetchEntityForKey<T:NSManagedObject>(entityName: String, id: Int16) -> T? {
        
        let fetchRequest = NSFetchRequest<T>(entityName: NSStringFromClass(T.self))
        
        let idPredicate = NSPredicate(format: "id == %i", id)
        fetchRequest.predicate = idPredicate
        
        do {
            let arrData = try viewContext.fetch(fetchRequest)
            
            if arrData.count > 0 {
                return arrData.first
            } else {
                return nil
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}

