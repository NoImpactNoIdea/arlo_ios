//
//  PushNotificationManager.swift
//  projectarlo
//
//  Created by Charlie Arcodia on 11/28/22.
//


import Foundation
import UIKit
import Firebase
import Alamofire

class PushNotificationManager : NSObject {
    
    static func sendPushNotification(title : String, body : String, user_uid : String, completion : @escaping (_ success : Any?, _ error : Any?) -> ()) {
        
        var token = String()
        
        let databaseRef = Database.database().reference()
        
        databaseRef.child("all_users").child(user_uid).observeSingleEvent(of: .value, with: { (snap : DataSnapshot) in
            
            guard let dic = snap.value as? [String : AnyObject] else {return}
            
            let pushToken = dic["device_push_token"] as? String ?? "nil"

            token = pushToken
            
            let url = "https://fcm.googleapis.com/fcm/send"
            
            var secretKey = ""
            
            if EnvironemntModeHelper.isCurrentEnvironmentDebug() == true {
                
                secretKey = "key = AAAAFEpzCxE:APA91bFp2hqxCz29No2EJlxInvQfYz7-8E5DGC-w0PlfpmIg_gJqKWEgTN1uNtlk5BPqGfJPZdYD_CQevD3D4MoTF9RNHj370vGFjg-kWYY0boB99nCwzn_KGwmMk2s3nabSFTKaFtra"
                
            } else {
                
                secretKey = "key = AAAAfctfyQU:APA91bFQ87YGPFZUSIp9bK9rfDwZLWlae0Pw4rNLY4GncM7tYE_9dIUUq0Zoom28U72hJJJi2lOTr-I73jz4FoKwZxjGRWQy882Onjat4FMyaf2TNVBdePBEmmaPDVV43-sgn7_lzsvJ"

            }
            
            let title = title
            let body = body
            
            let headers : HTTPHeaders = ["Content-Type" : "application/json",
                                         "Authorization" : secretKey]
            
            let notificationsParameters: Parameters = [
                
                "to": token,
                "content-available":true,
                "priority":"high",
                
                "notification" : [
                    "title" : title,
                    "body" : body,
                    "sound" : "chaching.mp3"

                ],
            ]
            
            AF.request(url, method: .post, parameters: notificationsParameters, encoding : JSONEncoding.default, headers: headers).responseJSON { response in
                
                switch response.result {
                    
                case .success:
                    
                    let data = response.value
                    completion(data, nil)
                    
                case .failure(let error):
                    
                    completion(nil, error)
                    
                }
            }
            
        }) { (true) in
            
        }
    }
}
