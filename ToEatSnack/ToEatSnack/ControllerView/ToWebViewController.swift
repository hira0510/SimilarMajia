//
//  ToWebViewController.swift
//  ToEatSnack
//
//  Copyright © 2020 1. All rights reserved.
//

import WebKit
import UIKit

class ToWebViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    var urls: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        requestUrl(url: urls)
        webView.navigationDelegate = self
    }

    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func requestUrl(url: String) {
        let url = URL(string: url)
        if let url = url {
            let request = URLRequest(url: url)
            webView.navigationDelegate = self
            webView.load(request)
        }
    }
}
