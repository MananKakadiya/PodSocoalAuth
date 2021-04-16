//
//  LinkedinHelperVC.swift
//  Bank2Grow
//
//  Created by CoruscateMAC on 22/03/19.
//  Copyright © 2019 Coruscate. All rights reserved.
//

import UIKit

class LinkedinHelperVC: UIViewController, UIWebViewDelegate {

    var CLIENT_ID = ""
    var CLIENT_SECRET = ""
    var REDIRECT_URI = ""
    var SCOPE = "r_basicprofile,r_emailaddress" //Get lite profile info and e-mail address
    var AUTHURL = "https://www.linkedin.com/oauth/v2/authorization"
    var TOKENURL = "https://www.linkedin.com/oauth/v2/accessToken"
    
    var isCallLinkedinApi :(() -> ())?
    
    //MARK: outlets
    @IBOutlet weak var webView: UIWebView!
    
    //MARK: view life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        
        startAuthorization()
    }

    @IBAction func btnClose_Click(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}


extension LinkedinHelperVC{
    // MARK: Custom Functions
    
    func startAuthorization() {
        
        let state = "linkedin\(Int(NSDate().timeIntervalSince1970))"
        let authURLFull = AUTHURL + "?response_type=code&client_id=" + CLIENT_ID + "&scope=" + SCOPE + "&state=" + state + "&redirect_uri=" + REDIRECT_URI
        
        // Create a URL request and load it in the web view.
        let request = URLRequest(url: URL(string: authURLFull)!)
        webView.loadRequest(request)
    }
    
    
    func requestForAccessToken(authorizationCode: String) {
        let grantType = "authorization_code"
        
        let redirectURL = "http://com.fintelligence.rupeecircleapp.oauth/oauth".addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        
        // Set the POST parameters.
        var postParams = "grant_type=\(grantType)&"
        postParams += "code=\(authorizationCode)&"
        postParams += "redirect_uri=\(REDIRECT_URI ?? "")&"
        postParams += "client_id=\(CLIENT_ID)&"
        postParams += "client_secret=\(CLIENT_SECRET)"
        
        // Convert the POST parameters into a NSData object.
        let postData = postParams.data(using: String.Encoding.utf8)
        
        
        // Initialize a mutable URL request object using the access token endpoint URL string.
        var request = URLRequest(url: URL(string: TOKENURL)!)
        
        // Indicate that we're about to make a POST request.
        request.httpMethod = "POST"
        
        // Set the HTTP body using the postData object created above.
        request.httpBody = postData
        
        // Add the required HTTP header field.
        request.addValue("application/x-www-form-urlencoded;", forHTTPHeaderField: "Content-Type")
        
        // Initialize a NSURLSession object.
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
//         Show Indicator
//        NetworkClient.sharedInstance.showIndicator("", stopAfter: 0.0)
        
        // Make the request.
        let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) -> Void in

//             Show Indicator
//            NetworkClient.sharedInstance.stopIndicator()
            
            let statusCode = (response as! HTTPURLResponse).statusCode
            
            if statusCode == 200 {
                // Convert the received JSON data into a dictionary.
                do {
                    if let dataDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any] {
                        
                        let accessToken = dataDictionary["access_token"] as! String
                        
                        UserDefaults.standard.set(accessToken, forKey: "LIAccessToken")
                        UserDefaults.standard.synchronize()
                        
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: {
                                self.isCallLinkedinApi?()
                            })
                        }
                    }
                }
                catch {
                    // Show AlertView
//                    Utilities.showAlertView(message: StringConstants.EmptyMessage.SomethingWrong)
                    print("Something went Wrong")
                }
            }
        }
        
        task.resume()
    }
    
    
    // MARK: UIWebViewDelegate Functions
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        let url = request.url!
        print(url)
        
        if url.host == "com.fintelligence.rupeecircleapp.oauth" {
            if url.absoluteString.range(of: "code") != nil {
                // Extract the authorization code.
                let urlParts = url.absoluteString.components(separatedBy: "?")
                let code = urlParts[1].components(separatedBy:"=")[1]
                
                requestForAccessToken(authorizationCode: code)
            }
        }
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
//        Show Indicator
//        NetworkClient.sharedInstance.showIndicator("", stopAfter: 0.0)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
//        Stop Indicator
//        NetworkClient.sharedInstance.stopIndicator()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
//        Stop Indicator
//        NetworkClient.sharedInstance.stopIndicator()
    }
    
}
