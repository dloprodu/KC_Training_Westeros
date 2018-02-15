//
//  WikiViewController.swift
//  Westeros
//
//  Created by David Lopez Rodriguez on 15/02/2018.
//  Copyright © 2018 David López Rodriguez. All rights reserved.
//

import UIKit
import WebKit

class WikiViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: - Properties
    let model: House
    
    init(model: House) {
        self.model = model
        
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        
        self.title = model.name
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.syncModelWithView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Sync
    func syncModelWithView() {
        self.webView.load(URLRequest(url: model.wikiURL))
    }
}

extension WikiViewController: UIWebViewDelegate {
    
}
