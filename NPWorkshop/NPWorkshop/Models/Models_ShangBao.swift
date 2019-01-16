//
//  Models_ShangBao.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/16.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class Models_ShangBao: NSObject {
    
    
    class Requesting: NSObject {
        var UserID:String
        var EqptName:String
        var AssetsNumber:String
        var Appearance:String
        var Parameter:String
        init(UserID:String,EqptName:String,AssetsNumber:String,Appearance:String,Parameter:String) {
            self.UserID = UserID
            self.EqptName = EqptName
            self.AssetsNumber = AssetsNumber
            self.Appearance = Appearance
            self.Parameter = Parameter
        }
    }
    class Response: NSObject {
        var ts:String?
        init(jsonData: JSON?){
            if let jsonData = jsonData{
                self.ts = jsonData["ts"].stringValue
            }
            print("ts: ", self.ts ?? "没有值")
        }
    }
    
    
    
}
