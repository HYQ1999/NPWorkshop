//
//  Models_SurePeijian.swift
//  NPWorkshop
//
//  Created by 欧张帆 on 2019/1/22.
//  Copyright © 2019 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Models_SurePeijian: NSObject {
    class Requesting: NSObject {
        var RepairID:String
        init(RepairID:String) {
            self.RepairID = RepairID
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
