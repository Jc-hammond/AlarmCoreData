//
//  AlarmDetailTableViewController.swift
//  AlarmCoreData
//
//  Created by Connor Hammond on 4/29/21.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {

    //MARK: - Outlets
    @IBOutlet weak var alarmFireDatePicker: UIDatePicker!
    @IBOutlet weak var alarmTitleTextField: UITextField!
    @IBOutlet weak var alarmIsEnabledButton: UIButton!
    
    
    //MARK: - Properties
    var alarm: Alarm?
    var isAlarmOn: Bool = true
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    //MARK: - Actions
    @IBAction func alarmIsEnabledButtonTapped(_ sender: Any) {
        if let alarm = alarm {
            AlarmController.sharedInstance.toggleIsEnabledFor(alarm: alarm)
            isAlarmOn = alarm.isEnabled
        } else {
            isAlarmOn = !isAlarmOn
        }
        designIsEnabledButton()
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = alarmTitleTextField.text, !title.isEmpty else {return}
        
        if let alarm = alarm {
            alarm.title = title
            AlarmController.sharedInstance.update(alarm: alarm, newTitle: title, newFireDate: alarmFireDatePicker.date, isAlarmOn: isAlarmOn)
        } else {
            AlarmController.sharedInstance.createAlarm(withTitle: title, and: alarmFireDatePicker.date, isAlarmOn: isAlarmOn)
        }
        
        
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helper Methods
    func updateViews() {
        guard let alarm = alarm else {return}
        alarmTitleTextField.text = alarm.title
        alarmFireDatePicker.date = alarm.fireDate ?? Date()
        isAlarmOn = alarm.isEnabled
        designIsEnabledButton()
    }
    
    func designIsEnabledButton() {
        switch isAlarmOn {
        case true:
            alarmIsEnabledButton.backgroundColor = .white
            alarmIsEnabledButton.setTitle("Enabled", for: .normal)
        case false:
            alarmIsEnabledButton.backgroundColor = .darkGray
            alarmIsEnabledButton.setTitle("Disabled", for: .normal)
        }
    }
    

}//End of class
