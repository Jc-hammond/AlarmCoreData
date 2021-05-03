//
//  AlarmTableViewCell.swift
//  AlarmCoreData
//
//  Created by Connor Hammond on 4/29/21.
//

import UIKit

//MARK: - Protocol
protocol AlarmTableViewCellDelegate: AnyObject {
    func alarmWasToggled(_ cell: AlarmTableViewCell)
}

class AlarmTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var alarmTitleLabel: UILabel!
    @IBOutlet weak var alarmFireDateLabel: UILabel!
    @IBOutlet weak var isEnabledSwitch: UISwitch!
    
    //MARK: - Properties
    weak var delegate: AlarmTableViewCellDelegate?
    var alarm: Alarm? {
    didSet {
        updateViews()
        }
    }
    
    
    //MARK: - Actions
    @IBAction func isEnabledSwitchToggled(_ sender: Any) {
        
        delegate?.alarmWasToggled(self)
    }
    
    //MARK: - Functions
    
    func updateViews() {
        guard let alarm = alarm else {return}
        alarmTitleLabel.text = alarm.title
        alarmFireDateLabel.text = alarm.fireDate?.stringValue()
        isEnabledSwitch.isOn = alarm.isEnabled
    }

}//End of class
