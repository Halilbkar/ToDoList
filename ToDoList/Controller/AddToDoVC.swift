//
//  AddToDoVC.swift
//  ToDoList
//
//  Created by Halil Bakar on 14.02.2023.
//

import UIKit
import CoreData

class AddToDoVC: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var taskTF: UITextField!
    @IBOutlet weak var notesTF: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    let context = appDelegate.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selector()
        selectedDate()
    }
    
    func selectedDate() {
        
        datePicker.addTarget(self, action: #selector(selector), for: .valueChanged)
    }
    
    @objc func selector() {
        
        dateString = CalendarManager.formatter(dateType, datePicker.date)
        
        dateLabel.text = dateString
        
        let timeString = CalendarManager.formatter(timeType, datePicker.date)
        
        timeLabel.text = timeString
    }
    
    @IBAction func addTask(_ sender: Any) {
        
        if let task = taskTF.text, let note = notesTF.text, let safeDate = dateLabel.text, let time = timeLabel.text {
            
            let myTasks = MyTasks(context: context)
            
            myTasks.task = task
            myTasks.note = note
            myTasks.time = time
            myTasks.date = safeDate
            
            appDelegate.saveContext()
            
            NotificationManager.localNotification(task, note, datePicker.date)
        }
        
        navigationController?.popToRootViewController(animated: true)
    }
}
