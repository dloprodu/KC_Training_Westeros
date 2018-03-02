//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by David Lopez Rodriguez on 25/02/2018.
//  Copyright © 2018 David López Rodriguez. All rights reserved.
//

import UIKit

class SeasonDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var seasonNameLabel: UILabel!
    @IBOutlet weak var seasonDateLabel: UILabel!
    @IBOutlet weak var seasonEpisodesLabel: UILabel!
    @IBOutlet weak var seasonImageView: UIImageView!
    
    // MARK: - Properties
    
    let formatter: DateFormatter
    var model: Season
    
    // MARK: - Initialization
    
    init(model: Season) {
        self.model = model
        self.formatter = DateFormatter()
        self.formatter.dateFormat = "yyyy-MM-dd"
        
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        
        self.title = "Season Detail"
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
        setupUI()
        syncModelWithView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    // MARK: - Sync
    func syncModelWithView() {
        self.seasonNameLabel.text = self.model.name;
        self.seasonDateLabel.text = self.formatter.string(from: self.model.releaseDate)
        self.seasonEpisodesLabel.text = "\(self.model.episodes.count) episodes"
        self.seasonImageView.image = self.model.image
    }
    
    // MARK: - UI
    func setupUI() {
        let episodesButton = UIBarButtonItem(title: "Episodes", style: .plain, target: self, action: #selector(displayEpisodes))
        
        self.navigationItem.rightBarButtonItems = [episodesButton]
    }
    
    // MARK: - Actions
    @objc func displayEpisodes() {
        let vc = EpisodeListViewController(model: self.model.episodes)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension SeasonDetailViewController : SeasonListViewControllerDelegate {
    func seasonListViewController(_ viewController: SeasonListViewController, didSelectSeason: Season) {
        self.model = didSelectSeason
        self.syncModelWithView()
    }
    
}

extension SeasonDetailViewController : UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let foregroundDetail = splitViewController?.viewControllers[1] else {
            return
        }
        guard let backgroundDetail = splitViewController?.viewControllers[2] else {
            return
        }
        
        // update tabBarController delegate
        tabBarController.delegate = (backgroundDetail as! UINavigationController).viewControllers.first as! HouseDetailViewController
        
        // swapping the views
        splitViewController?.viewControllers[2] = foregroundDetail
        splitViewController?.viewControllers[1] = backgroundDetail
    }
}
