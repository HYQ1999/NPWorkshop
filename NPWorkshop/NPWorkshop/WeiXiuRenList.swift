//
//  WeiXiuRenList.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/19.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit

class WeiXiuRenList: NSObject,NSCoding {

    var userid:String
    var username:String
    var userqx:String
    required init(userid:String = "", username:String = "", userqx: String = ""){
        self.userid = userid
        self.username = username
        self.userqx = userqx
        // super.init()
    }
    
    //从nsobject解析回来
    required init(coder decoder:NSCoder){
        self.userid = decoder.decodeObject(forKey: "userid") as! String
        self.username = decoder.decodeObject(forKey: "username") as! String
        self.userqx = decoder.decodeObject(forKey: "userqx")as! String
    }
    
    //编码成object
    func encode(with coder : NSCoder){
        coder.encode(userid,forKey:"userid")
        coder.encode(username,forKey:"username")
        coder.encode(userqx, forKey: "userqx")
    }
    
    
}
