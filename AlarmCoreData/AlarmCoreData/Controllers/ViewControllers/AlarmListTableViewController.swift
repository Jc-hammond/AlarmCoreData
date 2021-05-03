//
//  AlarmListTableViewController.swift
//  AlarmCoreData
//
//  Created by Connor Hammond on 4/29/21.
//

import UIKit

//I couldn't get this to work as an extension for whatever reson, it would give me an error when i assigned cell.delegate = self in the CellForRow at
class AlarmListTableViewController: UITableViewController, AlarmTableViewCellDelegate {
    func alarmWasToggled(_ cell: AlarmTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
        AlarmController.sharedInstance.toggleIsEnabledFor(alarm: alarm)
        cell.updateViews()
    }
    
   

    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.sharedInstance.alarms.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? AlarmTableViewCell else { return UITableViewCell() }

        let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
        
        cell.alarm = alarm
        cell.delegate = self
    
        return cell
    }
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alarmToDelete = AlarmController.sharedInstance.alarms[indexPath.row]
            AlarmController.sharedInstance.delete(alarm: alarmToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } }

  
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? AlarmDetailTableViewController else {return}
            let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
            destination.alarm = alarm
        }
    }
    
    
}//End of class

