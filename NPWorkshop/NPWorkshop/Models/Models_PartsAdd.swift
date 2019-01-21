//
//  Models_PartsAdd.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/21.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Models_PartsAdd: NSObject {
    
    class Requesting: NSObject {
        var PartsAmount:String
        var PartsID:String
        var RepairID:String
        init(PartsAmount:String,PartsID:String,RepairID:String) {
            self.PartsAmount = PartsAmount
            self.PartsID = PartsID
            self.RepairID = RepairID
        }
    }
    
    class Response: NSObject {
        var ts:String?
        
        init(jsonData: JSON?){
            if let jsonData = jsonData{
                self.ts = jsonData["returnts"].stringValue
            }
            print("ts: ", self.ts ?? "没有值")
        }
    }
    
    
}
