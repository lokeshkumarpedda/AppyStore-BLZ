//
//  RatingViewController.swift
//  AppyStoreBLZ
//
//  Purpose : Displaying the appy store app in the web
//
//  Created by Lokesh Kumar on 16/09/16.
//  Copyright © 2016 bridgelabz. All rights reserved.
//

import UIKit
import WebKit

class RatingViewController: UIViewController {

    var mWebView : WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mWebView?.navigationDelegate = self
        let url = NSURL(string: "https://play.google.com/store/apps/details?id=com.appy.store.lite")
        let request = NSURLRequest(URL: url!)
        mWebView?.loadRequest(request)
    }
    
    override func loadView() {
        super.loadView()
        mWebView = WKWebView()
        self.view = mWebView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func backButton(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
}
extension RatingViewController : WKNavigationDelegate{
    
    //Start the network activity indicator when webview is loading
    @objc func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    //Stops the network activity indicator when webview loading is finished
    @objc func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
}
