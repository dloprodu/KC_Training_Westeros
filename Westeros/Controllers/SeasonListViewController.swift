//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by David Lopez Rodriguez on 25/02/2018.
//  Copyright © 2018 David López Rodriguez. All rights reserved.
//

import UIKit

enum SeasonListViewControllerKeys: String {
    case SeasonKey
    case SeasonDidChangeNotificationName
    case LastSeason
}

protocol SeasonListViewControllerDelegate: class {
    // should, will, did
    func seasonListViewController (_ viewController: SeasonListViewController, didSelectSeason: Season)
}

class SeasonListViewController: UITableViewController {
    
    // MARK: - Properties
    
    let model: [Season]
    weak var delegate: SeasonListViewControllerDelegate?
    
    // MARK: - initialization
    
    init (model: [Season]) {
        self.model = model
        super.init(style: .plain)
        title = "Westeros"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let lastRow = UserDefaults.standard.integer(forKey: SeasonListViewControllerKeys.LastSeason.rawValue)
        let indexPath = IndexPath(item: lastRow, section: 0)
        
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.model.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "SeasonCell"
        let season = model[indexPath.row]
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        cell?.imageView?.image = season.image
        cell?.textLabel?.text = season.name
        
        return cell!
    }

    override func tableView(_ tableview: UITableView, didSelectRowAt indexPath: IndexPath) {
        let season = self.model[indexPath.row]
        
        delegate?.seasonListViewController(self, didSelectSeason: season)
        
        // Mando la misma info a traves de notificaciones
        let notification = Notification(name: Notification.Name(SeasonListViewControllerKeys.SeasonDidChangeNotificationName.rawValue), object: self, userInfo: [SeasonListViewControllerKeys.SeasonKey.rawValue: season])
        
        NotificationCenter.default.post(notification)
        
        // Guardar las coordenadas (section, row) de la última casa seleccionada
        saveLastSelectedSeason(at: indexPath.row)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}

extension SeasonListViewController {
    func saveLastSelectedSeason(at row: Int) {
        let defaults = UserDefaults.standard
        defaults.set(row, forKey: SeasonListViewControllerKeys.LastSeason.rawValue)
        defaults.synchronize()
    }
    
    func lastSelectedSeason() -> Season {
        let row = UserDefaults.standard.integer(forKey: SeasonListViewControllerKeys.LastSeason.rawValue)
        return model[row]
    }
}
