//
//  PetsDetailViewController.swift
//  SepiaTask
//
//  Created by Kiran Jadhav on 29/11/22.
//

import UIKit
import WebKit


class PetsDetailViewController: UIViewController {

    var contentURL:String = ""
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    class func instanceFromStoryboard(contentURL:String) -> PetsDetailViewController? {
        let vc = UIStoryboard.main.instantiateViewController(withIdentifier: String.petsDetailViewController) as? PetsDetailViewController
        vc?.contentURL = contentURL
        return vc
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPetDetailFromURL()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PetsDetailViewController {
    
    // Load WKWebview from URL
    func loadPetDetailFromURL(){
        
        webView.navigationDelegate = self
        webView.load(URLRequest(url: URL(string:contentURL)!))

    }
    
    // Show Activity Indicator when webView load
    func showActivityIndicator(isShow:Bool){
        
        if isShow{
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        }
        else{
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
        
    }
    
}


// MARK: - WKNAV DELEGATE METHODS
extension PetsDetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        showActivityIndicator(isShow: true)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showActivityIndicator(isShow: false)
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showActivityIndicator(isShow: false)
    }
    
}
