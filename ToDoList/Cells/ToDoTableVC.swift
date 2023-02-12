//
//  ToDoTableVC.swift
//  ToDoList
//
//  Created by Halil Bakar on 13.02.2023.
//

import UIKit

protocol isCheckProtocol {
    
    func isCheck(_ indexPath: Int)
}

class ToDoTableVC: UITableViewCell {

    @IBOutlet weak var hoursLabel: UILabel! //DateLabel olarak değiştir.
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var okeyButtonOutlet: UIButton!
    @IBOutlet weak var cellBack: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    var isCheck: isCheckProtocol?
    var indexPath: Int?
        
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellBack.layer.cornerRadius = 50
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func okeyButton(_ sender: UIButton) {
            
        isCheck?.isCheck(indexPath!)
    }
        
    func tableSetup(_ myTasks: MyTasks) {
        
        taskLabel.text = myTasks.task
        noteLabel.text = myTasks.note
        hoursLabel.text = myTasks.date
        timeLabel.text = myTasks.time
        
        cellCheck(myTasks)
        
        func cellCheck(_ myTasks: MyTasks) {
            
            if myTasks.isOkey {
                cellOkey()
                
            } else {
                cellNotOkey()
            }
            
            func cellOkey() {
                
                okeyButtonOutlet.tintColor = .systemGreen
                hoursLabel.textColor = .systemGray4
                taskLabel.textColor = .systemGray4
                noteLabel.textColor = .systemGray4
                timeLabel.textColor = .systemGray4
                cellBack.backgroundColor = .systemGray4
            }
            
            func cellNotOkey() {
               
                okeyButtonOutlet.tintColor = .systemGray4
                hoursLabel.textColor = .label
                taskLabel.textColor = .label
                noteLabel.textColor = .label
                timeLabel.textColor = .label
                cellBack.backgroundColor = UIColor(named: "indigo")
            }
        }
    }
    
    
    
    
    
    
}
