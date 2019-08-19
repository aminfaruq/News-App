//
//  DetailViewController.swift
//  My News
//
//  Created by Amin faruq on 19/08/19.
//  Copyright © 2019 Amin faruq. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController , WKNavigationDelegate{
    
    @IBOutlet var webView: WKWebView!
    var urlWeb : String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = URL(string: urlWeb!)
        webView.load(URLRequest(url: url!))
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

}
