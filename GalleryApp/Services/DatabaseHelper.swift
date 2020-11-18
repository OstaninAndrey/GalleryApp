//
//  DatabaseHelper.swift
//  GalleryApp
//
//  Created by Андрей Останин on 13.11.2020.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper {
    static let shared = DatabaseHelper()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveLocalImage(id: Int, data: Data) {
        let photo = NSEntityDescription.insertNewObject(forEntityName: "FullPhoto", into: context) as! FullPhoto
        photo.id = Int64(id)
        photo.image = data
        
        do{
            try context.save()
            print("Image succesfully saved")
        } catch let err {
            print(err.localizedDescription)
        }
        
//        context.persistentStoreCoordinator?.persistentStores.forEach({
//            if let url = $0.url {
//                print(url)
//            }
//        })
        
    }
    
    func someEntityExists(id: Int) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FullPhoto")
        fetchRequest.predicate = NSPredicate(format: "id = %d", id)
        fetchRequest.includesSubentities = false

        var entitiesCount = 0

        do {
            entitiesCount = try context.count(for: fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }

        return entitiesCount > 0
    }
    
    
    func getAllImages() -> [FullPhoto] {
        var arr: [FullPhoto] = []
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FullPhoto")
        
        do {
            arr = try context.fetch(request) as! [FullPhoto]
        } catch {
            print(error)
        }
        
        return arr
    }
    
}
