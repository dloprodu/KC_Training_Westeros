//
//  HouseListViewController.swift
//  Westeros
//
//  Created by David Lopez Rodriguez on 15/02/2018.
//  Copyright © 2018 David López Rodriguez. All rights reserved.
//

import UIKit

enum HouseListViewControllerNotifications: String {
    case HouseKey
    case HouseDidChangeNotificationName
}

protocol HouseListViewControllerDelegate {
    // should, will, did
    func houseListViewController (_ viewController: HouseListViewController, didSelectHouse: House)
}

class HouseListViewController: UITableViewController {
    
    // MARK: - Properties
    
    let model: [House]
    var delegate: HouseListViewControllerDelegate?
    
    // MARK: - initialization
    
    init (model: [House]) {
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "HouseCell"
        let house = model[indexPath.row]
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        cell?.imageView?.image = house.sigil.image
        cell?.textLabel?.text = house.name
        
        return cell!
    }

    override func tableView(_ tableview: UITableView, didSelectRowAt: IndexPath) {
        let house = self.model[didSelectRowAt.row]
        
        //let houseVC = HouseDetailViewController(model: house)
        //self.navigationController?.pushViewController(houseVC, animated: true)
        
        delegate?.houseListViewController(self, didSelectHouse: house)
        
        // Mando la misma info a traves de notificaciones
        let notification = Notification(name: Notification.Name(HouseListViewControllerNotifications.HouseDidChangeNotificationName.rawValue), object: self, userInfo: [HouseListViewControllerNotifications.HouseKey.rawValue: house])
        
        NotificationCenter.default.post(notification)
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
