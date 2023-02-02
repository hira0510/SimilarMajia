//
//  ExhibitionWebViewController.swift
//  ExhibitionIntroduction
//
//  Created by Hira on 2020/5/26.
//  Copyright © 2020 1. All rights reserved.
//

import UIKit
import WebKit

class ExhibitionWebViewController: UIViewController {

    @IBOutlet weak var mWebView: WKWebView!
    
    var urls: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mWebView.navigationDelegate = self
        loadURL(urlString: urls)
    }

    private func loadURL(urlString: String) {
        let url = URL(string: urlString)
        if let url = url {
            let request = URLRequest(url: url)
            mWebView.navigationDelegate = self
            mWebView.load(request)
        }
    }
}

extension ExhibitionWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
    }
}
