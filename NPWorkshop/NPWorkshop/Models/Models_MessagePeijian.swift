//
//  Models_MessagePeijian.swift
//  NPWorkshop
//
//  Created by 欧张帆 on 2019/1/21.
//  Copyright © 2019 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Models_MessagePeijian: NSObject {
    
    
    class Requesting: NSObject {
      
        var PartsAmount:String
        var PartsID:String
        var ApplyUser:String
          var UserID:String
        init(PartsAmount:String,PartsID:String,ApplyUser:String,UserID:String) {
            
            self.PartsAmount = PartsAmount
            self.PartsID = PartsID
            self.ApplyUser = ApplyUser
            self.UserID = UserID
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
