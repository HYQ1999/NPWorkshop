//
//  Models_WeiXiu.swift
//  NPWorkshop
//
//  Created by 欧张帆 on 2019/1/16.
//  Copyright © 2019 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class Models_Weixiu: NSObject {
    //    /// 请求
    //        class Requesting: NSObject {
    //            var FixID:String
    //
    //            init(UserId:String) {
    //                self.UserId = UserId
    //            }
    //        }
    
    /// 响应
    class Response: NSObject {
        var RepairID:String?
        var EqptName:String?
        var RepairState:String?
        
        init(
            RepairID: String?,
            EqptName: String?,
            RepairState: String?
            ){
            self.RepairID = RepairID
            self.EqptName = EqptName
            self.RepairState = RepairState
            
        }
    }
    
}

