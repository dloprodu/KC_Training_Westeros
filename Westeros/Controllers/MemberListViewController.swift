//
//  MemberListViewController.swift
//  Westeros
//
//  Created by David Lopez Rodriguez on 19/02/2018.
//  Copyright © 2018 David López Rodriguez. All rights reserved.
//

import UIKit

class MemberListViewController: UITableViewController {
    // MARK: - Properties
    var model: [Person]
    
    // MARK: - Init
    init(model: [Person]) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        
        self.title = "Members"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Si fuese un UIViewController con un TableView como
        // subvista ...
        // 1. Asignamos delegado
        // tableView.delegate = self
        // tableView.dataSource = self
        // 2. Implementar delegados como extensión
        // UITableViewDelegate
        // UITableViewDataSource
        // - numberOfRowsInSection
        // - cellForRowAt
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "MemberCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            ?? UITableViewCell(style: .default, reuseIdentifier: cellId)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let person = model[indexPath.row]
        cell.textLabel?.text = person.fullName
        cell.accessoryType = .disclosureIndicator
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let member = self.model[indexPath.row]
        
        navigationController?.pushViewController(MemberDetailViewController(model: member), animated: true)
    }

    // MARK: - Selectors
    @objc func houseDidChange(notification: Notification) {
        // Extraer el userInfo de la notificación
        guard let info = notification.userInfo else {
            return
        }
        
        guard let house = info[HouseListViewControllerKeys.LastHouse.rawValue] as? House else {
            return
        }
        
        self.model = house.members
        self.tableView.reloadData()
    }
}

