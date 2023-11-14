//
//  WebViewController.swift
//  LinkyAPI
//
//  Created by Karim Angama on 13/06/2023.
//

import Foundation
import UIKit
import WebKit


class WebViewController: UIViewController {
    
    typealias WebViewBlock = (_ usagePointsId: String?, _ state: String?, _ error: Error?) -> Void
    var configuration: LinkyConfiguration!
    var indicator: UIActivityIndicatorView!
    var webView: WKWebView!
    var block: WebViewBlock
    var account: LinkyAccount!
    
    required init(
        configuration: LinkyConfiguration,
        account: LinkyAccount,
        block: @escaping WebViewBlock) {
        self.block = block
        super.init(nibName: nil, bundle: nil)
        self.configuration = configuration
        self.account = account
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override methode
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
        setupUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        checkCodeIsSaved()
    }
    
    // MARK: - Public methode
    
    func setupUI() {
        setupBar()
        setupActivityIndicator()
    }
    
    func checkCodeIsSaved() {
        if let usagePointsId = account.getUsagePointsId() {
            block(usagePointsId, configuration.state, nil)
            return
        }
        loadRequestWebView()
    }
    
    func loadRequestWebView() {
        let request = URLRequest(url: configuration.urlAuthorize!)
        webView.load(request)
    }
    
    internal func handleWebViewResponse(_ response: HTTPURLResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        var url = response.url
        switch configuration.mode {
            case .sandbox(prm: let client):
            url = URL(string: "http://\(configuration.redirectURI)?state=\(configuration.state)&usage_point_id=\(client.prm)")
            case .production: break
        }
        
        if let host = url?.host,
           host.contains(configuration.redirectURI.absoluteString) && response.statusCode == 200 {
            
            guard let url = url,
                  let urlComps = URLComponents(url: url, resolvingAgainstBaseURL: false),
                  let state = urlComps.queryItems?.first(where: { $0.name == Constants.Config.nameState })?.value,
                  let usagePointsId = urlComps.queryItems?.first(where: { $0.name == Constants.Config.usagePointId })?.value else {
                block(nil, nil, LinkyAuthorizationError.apiError)
                decisionHandler(.cancel)
                return
            }
            
            block(usagePointsId, state, nil)
            
            decisionHandler(.cancel)
        }else if(!(200...299).contains(response.statusCode)) {
            
            block(nil, nil, LinkyAuthorizationError(rawValue: response.statusCode))
            
            decisionHandler(.cancel)
        }else {
            decisionHandler(.allow)
        }
    }
    
    // MARK: - Private methode
    
    private func setupBar() {
        let barButton = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(closeWindow)
        )
        navigationItem.rightBarButtonItem = barButton
    }
    
    private func setupActivityIndicator() {
        indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        view.addSubview(indicator)
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc private func closeWindow() {
        dismiss(animated: true)
    }
    
    deinit {
        print("Deinit - WebViewController")
    }
}


extension WebViewController: WKUIDelegate, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        let response = navigationResponse.response as! HTTPURLResponse
        handleWebViewResponse(response, decisionHandler: decisionHandler)
    }
    
}
