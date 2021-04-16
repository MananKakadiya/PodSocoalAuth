//
//  LinkedInSignInHelper.swift
//  Bank2Grow
//
//  Created by Vish on 18/05/18.
//  Copyright © 2018 Coruscate. All rights reserved.
//

import UIKit

class LinkedInSignInHelper: NSObject {

    static let sharedInstance = LinkedInSignInHelper()
    var userInfo : ((_ userData : SocialSigninModel) -> ())?
    
    var model = SocialSigninModel()
    
    
    func callSignIn(clienID : String, clientSecret : String, redirectURI : String) {
           
           let vc = LinkedinHelperVC.init(nibName: "LinkedinHelperVC", bundle: LinkedInSignInHelper.bundle)
           vc.isCallLinkedinApi = {
               self.callApiforGetLinkedinUserInfo()
           }
        vc.CLIENT_ID = clienID
        vc.CLIENT_SECRET = clientSecret
        vc.REDIRECT_URI = redirectURI
           UIViewController.current().present(vc, animated: true, completion: nil)

       }
    
 static var bundle:Bundle {
     let podBundle = Bundle(for: LinkedInSignInHelper.self)
     
     let bundleURL = podBundle.url(forResource: "MKFBLogin", withExtension: "bundle")
     return Bundle(url: bundleURL!)!
 }
    
    func callApiforGetLinkedinUserInfo(){
        if let accessToken = UserDefaults.standard.object(forKey: "LIAccessToken") {

            let targetURLString = "https://www.linkedin.com/v1/people/~:(id,first-name,last-name,email-address,picture-url,formatted-name,positions,public-profile-url,headline,industry,specialties)?format=json"
            

            var request = URLRequest(url: URL(string: targetURLString)!)
            request.httpMethod = "GET"
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) -> Void in
                let statusCode = (response as! HTTPURLResponse).statusCode
                
                if statusCode == 200 {
                    do {
                        if let dict = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]{
                            
                            print(dict)
            
                            self.model.email = dict["emailAddress"] as? String
                            self.model.lastName = dict["lastName"] as? String
                            self.model.firstName = dict["firstName"] as? String
                            self.model.id = dict["id"] as? String
            
                            if let userData = self.userInfo{
                                userData(self.model)
                            }
                            
                            var param = [String:Any]()
                            param["id"] = dict["id"] as? String
                            param["name"] = dict["formattedName"] as? String
                            param["email"] = dict["emailAddress"] as? String
                            param["avatar"] = dict["pictureUrl"] as? String
                            param["social_type"] = 3
                            param["user"] = dict
                            
                            
                        }
                    }
                    catch {
                        print("Could not convert JSON data into a dictionary.")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}


class SocialSigninModel: NSObject {

    var id : String?
    var firstName : String?
    //var middleName : String?
    var lastName : String?
    var email : String?
    var profileURl : String?
    var name : String?
}


