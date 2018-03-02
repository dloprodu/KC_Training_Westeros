//
//  MemberDetailTableViewController.swift
//  Westeros
//
//  Created by David Lopez Rodriguez on 02/03/2018.
//  Copyright © 2018 David López Rodriguez. All rights reserved.
//

import UIKit

class MemberDetailViewController: UITableViewController {
    // MARK: - Properties
    
    let model: Person
    
    // MARK: - Initialization
    
    init (model: Person) {
        self.model = model
        super.init(style: .grouped)
        title = "Member"
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(houseDidChange), name: Notification.Name( HouseListViewControllerKeys.HouseDidChangeNotificationName.rawValue ), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Member Data"
        default:
            return "House Data"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "MemberCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            ?? UITableViewCell(style: .value2, reuseIdentifier: cellId)
        
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Nme"
                cell.detailTextLabel?.text = model.name
            case 1:
                cell.textLabel?.text = "Alias"
                cell.detailTextLabel?.text = model.alias
            default:
                cell.textLabel?.text = "Full name"
                cell.detailTextLabel?.text = model.fullName
            }
        default:
            cell.textLabel?.text = "House name"
            cell.detailTextLabel?.text = model.house.name
        }
        
        return cell
    }
    
    // MARK: - Selectors
    @objc func houseDidChange(notification: Notification) {
        navigationController?.popToRootViewController(animated: false)
    }
}

