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

    var mWebView : WKWebView?   //webview for displaying web content
    
    //when view loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        //adding delegate
        mWebView?.navigationDelegate = self
        
        let url = NSURL(string: "https://play.google.com/store/apps/details?id=com.appy.store.lite")
        let request = NSURLRequest(URL: url!)
        
        //requesting the url
        mWebView?.loadRequest(request)
    }
    //when view loaded
    override func loadView() {
        super.loadView()
        mWebView = WKWebView()
        self.view = mWebView
    }
    
    //when memory warning recieved
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //going back to previous view
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
