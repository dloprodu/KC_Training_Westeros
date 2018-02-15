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
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
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
        self.setupUI();
        self.syncModelWithView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UI
    func setupUI() {
        self.activityView.hidesWhenStopped = true
        self.activityView.startAnimating()
        self.webView.navigationDelegate = self
    }
    
    // MARK: - Sync
    func syncModelWithView() {
        self.webView.load(URLRequest(url: model.wikiURL))
    }
}

extension WikiViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityView.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityView.stopAnimating()
    }
}
