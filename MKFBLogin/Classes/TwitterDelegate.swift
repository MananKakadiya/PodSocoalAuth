//
//  TwitterDelegate.swift
//  MKFBLogin
//
//  Created by iMac on 05/02/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit
import TwitterKit


open class TwitterDelegate {
    
    public static func getTwitterData( success: @escaping (([String : Any])->Void)){
        
        var data = [String : Any]()
        var UserData = NSMutableDictionary()
        
        TWTRTwitter.sharedInstance().logIn(completion: { (session, error) in
            let client = TWTRAPIClient.withCurrentUser()
            print(session as Any)
            UserData["userName"] = session?.userName
            UserData["authToken"] = session?.authToken
            
            client.requestEmail { email, error in
                UserData["email"] = (email ?? "") as String
                print(email as Any)
            }
            
            client.loadUser(withID: session?.userID ?? "", completion: { (userInfo, erro) in
                UserData["userID"] = userInfo?.userID
                UserData["profilePic"] = userInfo?.profileImageLargeURL
                UserData["name"] = userInfo?.name
                
                data = ["data": UserData]
                
                
                success(data)
                
            })
            //androidcoruscatedebug@gmail.com
            // Android@Debug
            
        })
        
    }
    
//    public static func setTwitterAPI_Key_And_Sectret(API_Key : String, API_Secret : String){
//        TWTRTwitter.sharedInstance().start(withConsumerKey: API_Key, consumerSecret: API_Secret)
//    }

}


