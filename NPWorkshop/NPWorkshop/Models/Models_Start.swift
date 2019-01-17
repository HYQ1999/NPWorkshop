//
//  Models_Start.swift
//  NPWorkshop
//
//  Created by 欧张帆 on 2019/1/17.
//  Copyright © 2019 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class Models_Start: NSObject {
    class Requesting: NSObject {
        var RepairID:String//返回
        var operation:String
        init(RepairID:String,operation:String) {
            self.RepairID = RepairID
            self.operation = operation
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
