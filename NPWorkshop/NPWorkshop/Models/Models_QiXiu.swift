//
//  Models_QiXiu.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/21.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Models_QiXiu: NSObject {

    class Requesting: NSObject {
        var RenGonfei:String
        var QiXiuReason:String
        init(RenGonfei:String,QiXiuReason:String) {
            self.RenGonfei = RenGonfei
            self.QiXiuReason = QiXiuReason
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
