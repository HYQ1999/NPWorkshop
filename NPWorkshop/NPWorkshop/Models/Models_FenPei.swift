//
//  Models_FenPei.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/19.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Models_FenPei: NSObject {

    class Requesting: NSObject {
        var repairaID:String
        var  RepairUserID:String
        init(repairaID:String,RepairUserID:String) {
            self.repairaID = repairaID
            self.RepairUserID = RepairUserID
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
