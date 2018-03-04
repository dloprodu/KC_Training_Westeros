//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by David Lopez Rodriguez on 25/02/2018.
//  Copyright © 2018 David López Rodriguez. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    // MARK: - Properties
    let formatter: DateFormatter
    var model: Episode
    
    // MARK: - Initialization
    init(model: Episode) {
        self.model = model
        self.formatter = DateFormatter()
        self.formatter.dateFormat = "yyyy-MM-dd"
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
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
        
        syncModelWithView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(seasonDidChange), name: Notification.Name( SeasonListViewControllerKeys.SeasonDidChangeNotificationName.rawValue ), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - Sync
    func syncModelWithView() {
        if (titleLabel == nil) {
            // The view, as delegate, tries to update model but it isn't ready because it've not been shown. It'll be updated when the view will appear.
            return
        }
        
        titleLabel.text = model.title
        imageView.image = model.image
        releaseDateLabel.text = formatter.string(from: model.releaseDate)
        summaryLabel.text = model.summary
        
        self.title = model.title
    }
    
    // MARK: - Selectors
    @objc func seasonDidChange(notification: Notification) {
        navigationController?.popToRootViewController(animated: false)
    }
}

extension EpisodeDetailViewController : EpisodeListViewControllerDelegate {
    func episodeListViewController(_ viewController: EpisodeListViewController, didSelectEpisode: Episode) {
        self.model = didSelectEpisode
        self.syncModelWithView()
    }
    
}
