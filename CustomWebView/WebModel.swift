//
//  WebViewKit.swift
//  WebViewKit
//
//  Created by Mandeep Singh on 16/07/19.
//  Copyright © 2019 Mandeep Singh. All rights reserved.
//
import Foundation
import UIKit

public class WebModel: UINavigationController {

    private let webVC: WebController!
    private var _didComplete: ((AnyObject?, Bool) -> Void)?
    
    public convenience init() {
        self.init(config: WebViewConfig.shared)
    }
    
    public required init(config: WebViewConfig) {
        WebViewConfig.shared = config
        webVC = WebController(url: config.webURL)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        viewControllers = [webVC]
        webVC.closeVC = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
            self?._didComplete?(nil, true)
        }
        webVC.resposeData = { [weak self] (data) in
            self?.dismiss(animated: true, completion: nil)
            self?._didComplete?(data, false)
        }
    }
    
    public func getData(completion: @escaping (_ body: AnyObject?, _ cancelled: Bool) -> Void) {
        _didComplete = completion
    }
    
    deinit {
        print("deinit WebKit")
    }
}

