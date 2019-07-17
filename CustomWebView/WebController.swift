//
//  WebController.swift
//  WebViewKit
//
//  Created by Mandeep Singh on 16/07/19.
//  Copyright © 2019 Mandeep Singh. All rights reserved.
//

import Foundation
import WebKit

final class WebController : UIViewController {
    
    private var webView: WKWebView!
    private var webURL: URL?
    var closeVC:(() -> Void)?
    var resposeData: ((AnyObject) -> Void)?
    
    init(url: String?) {
        if let openURL = url {
            self.webURL = URL(string: openURL)
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setWebView()
        WebConfig.isOneView == true ? self.singleView() : self.loadWebView()
        self.addBarButtons()
    }
    
    private func setWebView() {
        
        let contentController = WKUserContentController();
        contentController.add(self, name: "myFunction")
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        self.webView = WKWebView(frame: self.view.bounds, configuration: config)
        self.webView.configuration.preferences.javaScriptEnabled = true
        
        self.view.addSubview(self.webView)
    }
    
    private func loadWebView() {
        if let clientURL = self.webURL {
            webView.load(URLRequest(url: clientURL))
        } else {
            guard let url = WebConfig.localPath else {
                fatalError("local Path not defined")
            }
            let baseUrl = URL(fileURLWithPath:url)
            webView.loadFileURL(baseUrl, allowingReadAccessTo: baseUrl)
        }
    }
    
    private func singleView() {
        
        if let clientURL = self.webURL {
            webView.load(URLRequest(url: clientURL))
            webView.evaluateJavaScript("setConfig('\(WebConfig.isOneView)')", completionHandler: nil)
        }
    }
    
    private func addBarButtons() {
        let leftButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelWebView))
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func cancelWebView() {
        self.closeVC?()
    }
}


extension WebController : WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        self.resposeData?(message.body as AnyObject)
    }
}


