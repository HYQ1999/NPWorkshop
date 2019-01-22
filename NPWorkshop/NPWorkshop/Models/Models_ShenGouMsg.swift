//
//  Models_ShenGouMsg.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/22.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit


class Models_ShenGouMsg: NSObject {
    
    class Response: NSObject {
        var message:String?
        var repairid:String?
        var shengouren:String?
        var shijian:String?
        init(
            message: String?,
            repairid: String?,
            shengouren: String?,
            shijian: String?
            ){
            self.message = message
            self.repairid = repairid
            self.shengouren = shengouren
            self.shijian = shijian
        }
    }
}
