//
//  GerenDetailList.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/19.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit

class GerenDetailList: NSObject,NSCoding {

    var username:String
    var userbumen:String
    var userqq:String
    var userdianhua:String
     var userpassword:String
    required init(username:String = "", userbumen:String = "", userqq: String = "", userdianhua:String = "", userpassword: String = ""){
        self.username = username
        self.userbumen = userbumen
        self.userqq = userqq
        self.userdianhua = userdianhua
        self.userpassword = userpassword
        // super.init()
    }
    
    //从nsobject解析回来
    required init(coder decoder:NSCoder){
        self.username = decoder.decodeObject(forKey: "username") as! String
        self.userbumen = decoder.decodeObject(forKey: "userbumen") as! String
        self.userqq = decoder.decodeObject(forKey: "userqq")as! String
        self.userdianhua = decoder.decodeObject(forKey: "userdianhua") as! String
        self.userpassword = decoder.decodeObject(forKey: "userpassword")as! String
    }
    
    //编码成object
    func encode(with coder : NSCoder){
        coder.encode(username,forKey:"username")
        coder.encode(userbumen,forKey:"userbumen")
        coder.encode(userqq, forKey: "userqq")
        coder.encode(userdianhua,forKey:"userdianhua")
        coder.encode(userpassword, forKey: "userpassword")
    }
    
}
