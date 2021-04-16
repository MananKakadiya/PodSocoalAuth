//
//  LinkedInDelegate.swift
//  MKFBLogin
//
//  Created by iMac on 11/02/21.
//  Copyright © 2021 iMac. All rights reserved.
//


import UIKit


open class LinkedInDelegate {
    
    public static func getLinkedInData(CLIENT_ID : String, CLIENT_SECRET : String, REDIRECT_URI : String, success: @escaping (([String : Any])->Void)){
        
        LinkedInSignInHelper.sharedInstance.callSignIn(clienID : CLIENT_ID, clientSecret : CLIENT_SECRET, redirectURI : REDIRECT_URI)
        LinkedInSignInHelper.sharedInstance.userInfo = { model in
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


