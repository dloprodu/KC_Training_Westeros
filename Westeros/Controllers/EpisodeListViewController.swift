//
//  EpisodeListViewController.swift
//  Westeros
//
//  Created by David Lopez Rodriguez on 25/02/2018.
//  Copyright © 2018 David López Rodriguez. All rights reserved.
//

import UIKit

enum EpisodeListViewControllerKeys: String {
    case EpisodeDidChangeNotificationName
    case LastEpisode
}

protocol EpisodeListViewControllerDelegate: class {
    // should, will, did
    func episodeListViewController (_ viewController: EpisodeListViewController, didSelectEpisode: Episode)
}

class EpisodeListViewController: UITableViewController {
    // MARK: - Properties
    
    var model: [Episode]
    weak var delegate: EpisodeListViewControllerDelegate?
    
    // MARK: - initialization
    
    init (model: [Episode]) {
        self.model = model
        super.init(style: .plain)
        title = "Episodes"
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(seasonDidChange), name: Notification.Name( SeasonListViewControllerKeys.SeasonDidChangeNotificationName.rawValue ), object: nil)
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
        return model.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "EpisodeCell"
        let episode = model[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            ?? UITableViewCell(style: .default, reuseIdentifier: cellId)
        
        cell.imageView?.image = episode.image
        cell.textLabel?.text = episode.title
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableview: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = self.model[indexPath.row]
        
        navigationController?.pushViewController(EpisodeDetailViewController(model: episode), animated: true)
        
        delegate?.episodeListViewController(self, didSelectEpisode: episode)
        
        // Mando la misma info a traves de notificaciones
        let notification = Notification(name: Notification.Name(EpisodeListViewControllerKeys.EpisodeDidChangeNotificationName.rawValue), object: self, userInfo: [EpisodeListViewControllerKeys.LastEpisode.rawValue: episode])
        
        NotificationCenter.default.post(notification)
    }
    
    // MARK: - Selectors
    @objc func seasonDidChange(notification: Notification) {
        // Extraer el userInfo de la notificación
        guard let info = notification.userInfo else {
            return
        }
        
        guard let season = info[SeasonListViewControllerKeys.LastSeason.rawValue] as? Season else {
            return
        }
        
        self.model = season.episodes
        self.tableView.reloadData()
    }
}
