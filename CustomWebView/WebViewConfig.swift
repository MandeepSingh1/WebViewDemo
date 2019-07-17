//
//  WebViewConfig.swift
//  WebViewKit
//
//  Created by Mandeep Singh on 16/07/19.
//  Copyright © 2019 Mandeep Singh. All rights reserved.
//

import Foundation

/// Typealias for code prettiness
internal var WebConfig: WebViewConfig { return WebViewConfig.shared }

public struct WebViewConfig {
    public static var shared: WebViewConfig = WebViewConfig()
    public var isOneView = true
    public var webURL: String?
    public var localPath: String?
}
