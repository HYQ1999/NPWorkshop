//
//  UserList.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/14.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit

class UserList: NSObject,NSCoding {
    var userid:String
    var userrole:String
    var quanxian:String
    required init(userid:String = "", userrole:String = "", quanxian: String = ""){
        self.userid = userid
        self.userrole = userrole
        self.quanxian = quanxian
        // super.init()
    }
    
    //从nsobject解析回来
    required init(coder decoder:NSCoder){
        self.userid = decoder.decodeObject(forKey: "userid") as! String
        self.userrole = decoder.decodeObject(forKey: "userrole") as! String
        self.quanxian = decoder.decodeObject(forKey: "quanxian")as! String
    }
    
    //编码成object
    func encode(with coder : NSCoder){
        coder.encode(userid,forKey:"userid")
        coder.encode(userrole,forKey:"userrole")
        coder.encode(quanxian, forKey: "quanxian")
    }
}
