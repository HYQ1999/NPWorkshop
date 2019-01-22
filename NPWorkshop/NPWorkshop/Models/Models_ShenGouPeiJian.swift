//
//  Models_ShenGouPeiJian.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/22.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Models_ShenGouPeiJian: NSObject {
    class Requesting: NSObject {
        var RepairID:String
        var PartsAmount:String
        var PartsID:String
        var ReplyUser:String
        var ApplyUser:String
        init(RepairID:String,PartsAmount:String,PartsID:String,ReplyUser:String,ApplyUser:String) {
             self.RepairID = RepairID
            self.PartsAmount = PartsAmount
            self.PartsID = PartsID
            self.ReplyUser = ReplyUser
             self.ApplyUser = ApplyUser
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
