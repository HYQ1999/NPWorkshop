//
//  Models_DaoHuoMsg.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/22.
//  Copyright © 2019年 韩意谦. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON

class Models_DaoHuoMsg: NSObject {

    class Response: NSObject {
        var message:String?
        var repairid:String?
        var fasonren:String?
         var shijian:String?
        init(
            message: String?,
            repairid: String?,
            fasonren: String?,
             shijian: String?
            ){
            self.message = message
            self.repairid = repairid
            self.fasonren = fasonren
             self.shijian = shijian
            
        }
    }
    
}
