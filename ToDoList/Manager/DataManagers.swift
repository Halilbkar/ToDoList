//
//  DataManagers.swift
//  ToDoList
//
//  Created by Halil Bakar on 19.02.2023.
//

import Foundation
import UIKit
import CoreData

struct DataManagers {
    
    static func allTasks(context: NSManagedObjectContext, taskTableView: UITableView, completion: @escaping ([MyTasks]) -> ()) {
        
        DispatchQueue.main.async {
            
            do {
                let myTasks = try? context.fetch(MyTasks.fetchRequest())
                
                if let myTasks = myTasks {
                    completion(myTasks)
                }
                
                DispatchQueue.main.async {
                    taskTableView.reloadData()
                }
                
            } catch {
                print(error)
            }
        }
    }
    
    static func selectDateTasks(context: NSManagedObjectContext, taskTableView: UITableView, dateString: String, completion: @escaping ([MyTasks]) -> ()) {
        
        let fetchrequest:NSFetchRequest<MyTasks> = MyTasks.fetchRequest()
        
        fetchrequest.predicate = NSPredicate(format: "date = %@", dateString)
        
        DispatchQueue.main.async {
            do {
                let myTasks = try? context.fetch(fetchrequest)
                
                if let myTasks = myTasks {
                    completion(myTasks)
                }
                
                DispatchQueue.main.async {
                    taskTableView.reloadData()
                }
                
            } catch {
                print(error)
            }
        }
    }
}
