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
        
        self.title = model.name
    }
    
    // MARK: - UI
    func setupUI() {
        //let wikiButton = UIBarButtonItem(title: "Wiki", style: .plain, target: self, action: #selector(displayWiki))
        //let membersButton = UIBarButtonItem(title: "Members", style: .plain, target: self, action: #selector(displayMembers))
        
        //self.navigationItem.rightBarButtonItems = [membersButton, wikiButton]
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SeasonDetailViewController : SeasonListViewControllerDelegate {
    func seasonListViewController(_ viewController: SeasonListViewController, didSelectSeason: Season) {
        self.model = didSelectSeason
        self.syncModelWithView()
    }
    
}
