//
//  Models_ShouLi.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/18.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Models_ShouLi: NSObject {

    class Requesting: NSObject {
        var RepairID:String
        var operation:String
        var RepairState:String
        init(RepairID:String,operation:String,RepairState:String) {
            self.RepairID = RepairID
            self.operation = operation
            self.RepairState = RepairState
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
