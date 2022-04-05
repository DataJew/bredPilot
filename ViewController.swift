//
//  ViewController.swift
//  bredWebViewStoryboard
//
//  Created by Justin Holt on 4/4/22.
//

import UIKit

// framework that allows webpage to open with app
import WebKit

class ViewController: UIViewController {
    
// define configuration for WebView to enable JavaScript
    let webView: WKWebView = {
        
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = prefs
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        
        return webView
    }()
    
// function to load URL view
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        
        guard let url = URL(string: "https://bred4anything.carrd.co") else {
            return
        }

// evaluate JavaScript in WebView
        webView.load(URLRequest(url: url))
        
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            self.webView.evaluateJavaScript("document.body.innerHTML") { result, error in
                guard let html = result as? String, error == nil else {
                    return
                }
                
                print(html)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }

}

