//
//  Models_JieXiu.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/17.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Models_JieXiu: NSObject {

    
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
