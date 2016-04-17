//
//  NetManager.swift
//  SDMapHome
//
//  Created by Allen on 16/4/16.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit
import AFNetworking
import SVProgressHUD

struct NetManager {
    static let netError = "network disconnect, please try again!"
    
    static func GET(urlString:String, parameters:[String:NSObject]?,showHUD:Bool = true,success:((NSObject?)->Void)?,failure:((NSError) ->Void)?){
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.timeoutInterval = 10
        manager.responseSerializer.acceptableContentTypes = ["text/html","application/json","image/png","text/plain"]
        if showHUD {
            SVProgressHUD.showWithStatus("login...")
        }
        manager.GET(urlString, parameters: parameters, success: { (task, reponseObject) ->Void in
            if showHUD{
                SVProgressHUD.dismiss()
            }
            success?(reponseObject as? NSObject)
            }) { (task, error) ->Void in
                if showHUD{
                    SVProgressHUD.dismiss()
                    SVProgressHUD.showErrorWithStatus(netError)
                }
                failure?(error)
        }
    }
    static func POST(urlString:String, parameters:[String:NSObject]?,showHUD:Bool = true,success:((NSObject?)->Void)?,failure:((NSError) ->Void)?){
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.timeoutInterval = 10
        if showHUD {
            SVProgressHUD.showWithStatus("login...")
        }
        manager.POST(urlString, parameters: parameters, success: { (task, reponseObject) ->Void in
            if showHUD{
                SVProgressHUD.dismiss()
            }
        }) { (task, error) ->Void in
            if showHUD{
                SVProgressHUD.dismiss()
                SVProgressHUD.showErrorWithStatus(netError)
            }
            failure?(error)
        }
    }
}
