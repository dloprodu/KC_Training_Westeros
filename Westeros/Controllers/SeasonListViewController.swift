//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by David Lopez Rodriguez on 25/02/2018.
//  Copyright © 2018 David López Rodriguez. All rights reserved.
//

import UIKit

enum SeasonListViewControllerKeys: String {
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
        title = "Seasons"
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
        
        let lastRow = UserDefaults.standard.integer(forKey: SeasonListViewControllerKeys.LastSeason.rawValue)
        let indexPath = IndexPath(item: lastRow, section: 0)
        
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "SeasonCell"
        let season = model[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            ?? UITableViewCell(style: .default, reuseIdentifier: cellId)
        
        cell.imageView?.image = season.image
        cell.textLabel?.text = season.name
        
        return cell
    }

    override func tableView(_ tableview: UITableView, didSelectRowAt indexPath: IndexPath) {
        let season = self.model[indexPath.row]
        let collapsed = splitViewController?.isCollapsed ?? true
        
        if collapsed {
            self.navigationController?.pushViewController(SeasonDetailViewController(model: season), animated: true)
        } else {
            delegate?.seasonListViewController(self, didSelectSeason: season)
        }
        
        // Mando la misma info a traves de notificaciones
        let notification = Notification(name: Notification.Name(SeasonListViewControllerKeys.SeasonDidChangeNotificationName.rawValue), object: self, userInfo: [SeasonListViewControllerKeys.LastSeason.rawValue: season])
        
        NotificationCenter.default.post(notification)
        
        // Guardar las coordenadas (section, row) de la última casa seleccionada
        saveLastSelectedSeason(at: indexPath.row)
    }
    
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
