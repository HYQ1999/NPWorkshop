//
//  Models_BaoxiuDetail.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/16.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit

class Models_BaoxiuDetail: NSObject {

    class Requesting: NSObject {
        var RepairID:String
        init(RepairID:String) {
            self.RepairID = RepairID
        }
    }
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
