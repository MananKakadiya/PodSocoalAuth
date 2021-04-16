//
//  GoogleHelperClass.swift
//  GitHub Search
//
//  Created by iMac on 15/02/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit
import GoogleSignIn

class GoogleSigninHelper: NSObject, GIDSignInDelegate{
    
    static let sharedInstance = GoogleSigninHelper()
    
    public var getUserInfo : ((_ user : SocialSigninModel) -> ())?
    
    var model = SocialSigninModel()
    
    func callGoogleSignin(viewController : UIViewController){
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = viewController
        GIDSignIn.sharedInstance().signIn()
    }
    
    // Present a view that prompts the user  to sign in with Google
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        UIViewController.current().present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        UIViewController.current().dismiss(animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (user) != nil{
            
            
            var param = [String:Any]()
            param["id"] = user.userID!
            param["name"] = user.profile.name ?? nil
            param["email"] = user.profile.email ?? nil
            param["avatar"] = user.profile.hasImage == true ?user.profile.imageURL(withDimension: 100).absoluteString : nil
            param["social_type"] = 2
            param["user"] = ["email" : user.profile.email,
                             "id": user.userID!,
                             "image" : (user.profile.imageURL(withDimension: 100).absoluteString != "") ? user.profile.imageURL(withDimension: 100).absoluteString : nil,
                             "name" : ["familyName" : user.profile.familyName ?? nil , "givenName" : user.profile.givenName ?? nil]]
            
            
            model.id = user.userID
            model.name = user.profile.name
            model.firstName = user.profile.givenName
            model.email = user.profile.email
            model.lastName = user.profile.familyName

            if let gmailUserInfo = getUserInfo{
                gmailUserInfo(model)
            }
        }
        UIViewController.current().dismiss(animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
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
