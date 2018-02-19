//
//  HouseDetailViewController.swift
//  Westeros
//
//  Created by David Lopez Rodriguez on 12/02/2018.
//  Copyright © 2018 David López Rodriguez. All rights reserved.
//

import UIKit

class HouseDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var wordsLabel: UILabel!
    
    // MARK: - Properties
    var model: House
    
    // MARK: - Initialization
    init(model: House) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        
        //self.tabBarItem.image = model.sigil.image
        self.title = model.name
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
        self.houseNameLabel.text = "House \(self.model.name)"
        self.sigilImageView.image = self.model.sigil.image
        self.wordsLabel.text = self.model.words
    }
    
    // MARK: - UI
    func setupUI() {
        let wikiButton = UIBarButtonItem(title: "Wiki", style: .plain, target: self, action: #selector(displayWiki))
        let membersButton = UIBarButtonItem(title: "Members", style: .plain, target: self, action: #selector(displayMembers))
        
        membersButton.isEnabled = self.model.membersSorted.count > 0
        
        self.navigationItem.rightBarButtonItems = [membersButton, wikiButton]
    }
    
    // MARK: - Actions
    @objc func displayWiki() {
        let vc = WikiViewController(model: self.model)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func displayMembers() {
        let vc = MemberListViewController(model: self.model.membersSorted)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HouseDetailViewController : HouseListViewControllerDelegate {
    func houseListViewController(_ viewController: HouseListViewController, didSelectHouse: House) {
        self.model = didSelectHouse
        self.syncModelWithView()
    }
    
}
