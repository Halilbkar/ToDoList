//
//  ViewController.swift
//  ToDoList
//
//  Created by Halil Bakar on 12.02.2023.
//

import UIKit
import CoreData
import FSCalendar

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class ToDoVC: UIViewController{
    
    @IBOutlet weak var userBack: UIImageView!
    @IBOutlet weak var buttomBack: UIImageView!
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var allButton: UIButton!
    
    private let context = appDelegate.persistentContainer.viewContext
    
    private var myTasks = [MyTasks]()
    
    var deSelectDate = Date()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        getAllTasks()
        
        allButton.isSelected = true
        calendarView.deselect(deSelectDate)
    }
    
    
    @IBAction func allButton(_ sender: Any) {
        
        getAllTasks()
        
        allButton.isSelected = true
        calendarView.deselect(deSelectDate)
    }
}

extension ToDoVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let myTasks = myTasks[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as! ToDoTableVC
        
        cell.indexPath = indexPath.row
        cell.isCheck = self
        
        cell.tableSetup(myTasks)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction (style: .destructive, title: "Delete")
        { (contextualAction, view, boolValue) in
            
            let myTasks = self.myTasks[indexPath.row]
            
            self.context.delete(myTasks)
            
            appDelegate.saveContext()
            
            self.getAllTasks()
            
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension ToDoVC: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        deSelectDate = date
        
        dateString = CalendarManager.formatter(dateType, date)
        
        getselectDateTasks()
        
        allButton.isSelected = false
        
    }
}

extension ToDoVC: isCheckProtocol {
    
    func isCheck(_ indexPath: Int) {
        
        let myTasks = myTasks[indexPath]
        
        if myTasks.isOkey {
            myTasks.isOkey = false
        } else {
            myTasks.isOkey = true
        }
        
        DispatchQueue.main.async {
            self.taskTableView.reloadData()
        }
    }
    
    private func getAllTasks() {
        
        DataManagers.allTasks(context: context, taskTableView: taskTableView) {
            [weak self] myTasks in
            
            guard let self = self else { return }
            self.myTasks = myTasks
        }
    }
    
    private func getselectDateTasks() {
        
        DataManagers.selectDateTasks(context: context, taskTableView: taskTableView, dateString: dateString) {
            [weak self] myTasks in
            
            guard let self = self else { return }
            self.myTasks = myTasks
        }
    }
    
    private func viewSetup() {
        
        CalendarManager.calendarSetup(calendarView)
        
        allButton.isSelected = true
        
        calendarView.dataSource = self
        calendarView.delegate = self
        
        taskTableView.delegate = self
        taskTableView.dataSource = self
        
        userBack.layer.cornerRadius = 20
        buttomBack.layer.cornerRadius = 20
    }
}



