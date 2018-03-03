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
    var model: House
    
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(houseDidChange), name: Notification.Name( HouseListViewControllerKeys.HouseDidChangeNotificationName.rawValue ), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
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
    
    // MARK: - Selectors
    @objc func houseDidChange(notification: Notification) {
        // Extraer el userInfo de la notificación
        guard let info = notification.userInfo else {
            return
        }
        
        guard let house = info[HouseListViewControllerKeys.LastHouse.rawValue] as? House else {
            return
        }
        
        self.model = house
        self.syncModelWithView()
    }
}

extension WikiViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityView.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityView.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        switch navigationAction.navigationType {
        case .formResubmitted, .linkActivated:
            decisionHandler(.cancel)
        default:
            decisionHandler(.allow)
        }
    }
}
