//
//  FaceBookDelegate.swift
//  FaceBookDelegateMethodss
//
//  Created by iMac on 16/12/20.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit



open class FaceBookDelegate {
          
      
    public static func getFaceBookData(viewController: UIViewController, success: @escaping (([String : AnyObject])->Void))
    {
        let fb : LoginManager = LoginManager()
        var resultData = [String : AnyObject]()
        
        fb.logIn(permissions: ["public_profile", "email"], viewController: viewController, completion: { succes in
            
            if((AccessToken.current) != nil){
                GraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                    if (error == nil){
                        resultData = result as! [String : AnyObject]
                        success(resultData)
                    }
                })
            }
        })
    }
    
    
     public static func setFaceBookInDidFinishLunch(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?){
           ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
       }
}


