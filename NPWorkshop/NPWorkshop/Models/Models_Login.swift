//
//  Models_Login.swift
//  NPWorkshop
//
//  Created by 韩意谦 on 2019/1/11.
//  Copyright © 2019 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class Models_Login: NSObject {
    
    /// 请求
    class Requesting: NSObject {
        var UserName:String
        var Password:String
        
        init(UserName:String,
             Password:String) {
            self.UserName = UserName
            self.Password = Password
        }
    }
    /// 响应
    class Response: NSObject {
        var id:String?
        var qx:String?
        var roel:String?
        var ts:String?
        
        init(jsonData: JSON?){
            if let jsonData = jsonData{
                self.id = jsonData["id"].stringValue
                self.qx = jsonData["qx"].stringValue
                self.roel = jsonData["roel"].stringValue
                self.ts = jsonData["ts"].stringValue
            }
            print("id: ", self.id ?? "没有值")
            print("qx: ", self.qx ?? "没有值")
            print("roel: ", self.roel ?? "没有值")
            print("ts: ", self.ts ?? "没有值")
        }
    }
    
}
