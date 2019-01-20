//
//  Models_WeiXiuGeRenDetail.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/20.
//  Copyright © 2019年 韩意谦. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON

class Models_WeiXiuGeRenDetail: NSObject {

    class Response: NSObject {
        var username:String?
        var role:String?
        var userqq:String?
        var userdianhua:String?
        var password:String?
        init(jsonData: JSON?){
            if let jsonData = jsonData{
                self.username = jsonData["UserName"].stringValue
                self.role = jsonData["role"].stringValue
                self.userqq = jsonData["QQ"].stringValue
                self.userdianhua = jsonData["Telphone"].stringValue
                self.password = jsonData["PassWord"].stringValue
            }
            print("username: ", self.username ?? "没有值")
            print("role: ", self.role ?? "没有值")
            print("userqq: ", self.userqq ?? "没有值")
            print("userdianhua: ", self.userdianhua ?? "没有值")
            print("password: ", self.password ?? "没有值")
        }
    }
    
}
