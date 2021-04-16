//
//  GoogleDelegate.swift
//  GitHub Search
//
//  Created by iMac on 17/12/20.
//  Copyright © 2020 iMac. All rights reserved.
//

import UIKit


open class LinkedInDelegate {
    
    public static func getGoogleData(viewController : UIViewController, success: @escaping (([String : Any])->Void)){
        
        GoogleSigninHelper.sharedInstance.callGoogleSignin(viewController: viewController)
        GoogleSigninHelper.sharedInstance.getUserInfo = { model in
            print(model)
            
            
            var userData = [String : Any]()
            userData["id"] =  model.id
            userData["firstName"] =  model.firstName
            userData["lastName"] =  model.lastName
            userData["email"] =  model.email
            userData["profileURl"] =  model.profileURl
            userData["name"] =  model.name
            success(userData)
        }
        
    }
    
}


