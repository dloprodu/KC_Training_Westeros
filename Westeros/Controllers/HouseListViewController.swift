//
//  HouseListViewController.swift
//  Westeros
//
//  Created by David Lopez Rodriguez on 15/02/2018.
//  Copyright © 2018 David López Rodriguez. All rights reserved.
//

import UIKit

enum HouseListViewControllerKeys: String {
    case HouseDidChangeNotificationName
    case LastHouse
}

protocol HouseListViewControllerDelegate: class {
    // should, will, did
    func houseListViewController (_ viewController: HouseListViewController, didSelectHouse: House)
}

class HouseListViewController: UITableViewController {
    
    // MARK: - Properties
    
    let model: [House]
    weak var delegate: HouseListViewControllerDelegate?
    
    // MARK: - initialization
    
    init (model: [House]) {
        self.model = model
        super.init(style: .plain)
        title = "Houses"
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let lastRow = UserDefaults.standard.integer(forKey: HouseListViewControllerKeys.LastHouse.rawValue)
        let indexPath = IndexPath(item: lastRow, section: 0)
        
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            ?? UITableViewCell(style: .default, reuseIdentifier: cellId)
        
        cell.imageView?.image = house.sigil.image
        cell.textLabel?.text = house.name
        
        return cell
    }

    override func tableView(_ tableview: UITableView, didSelectRowAt indexPath: IndexPath) {
        let house = self.model[indexPath.row]
        let collapsed = splitViewController?.isCollapsed ?? true
        
        if collapsed {
            self.navigationController?.pushViewController(HouseDetailViewController(model: house), animated: true)
        } else {
            delegate?.houseListViewController(self, didSelectHouse: house)
        }
        
        // Mando la misma info a traves de notificaciones
        let notification = Notification(name: Notification.Name(HouseListViewControllerKeys.HouseDidChangeNotificationName.rawValue), object: self, userInfo: [HouseListViewControllerKeys.LastHouse.rawValue: house])
        
        NotificationCenter.default.post(notification)
        
        // Guardar las coordenadas (section, row) de la última casa seleccionada
        saveLastSelectedHouse(at: indexPath.row)
    }
}

extension HouseListViewController {
    func saveLastSelectedHouse(at row: Int) {
        let defaults = UserDefaults.standard
        defaults.set(row, forKey: HouseListViewControllerKeys.LastHouse.rawValue)
        defaults.synchronize()
    }
    
    func lastSelectedHouse() -> House {
        let row = UserDefaults.standard.integer(forKey: HouseListViewControllerKeys.LastHouse.rawValue)
        return model[row]
    }
}
