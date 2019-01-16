//
//  Models_CheXiao.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/15.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class Models_CheXiao: NSObject {
    class Requesting: NSObject {
        var RepairID:String
        var operation:String
        var RepairState:String
        var Mark1:String
        init(RepairID:String,operation:String,RepairState:String,Mark1:String) {
            self.RepairID = RepairID
            self.operation = operation
            self.RepairState = RepairState
            self.Mark1 = Mark1
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
