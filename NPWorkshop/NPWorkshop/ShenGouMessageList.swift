//
//  ShenGouMessageList.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/22.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit

class ShenGouMessageList: NSObject,NSCoding {

    var shengouren:String
    var shijian:String
    var message:String
    var repairid:String
    required init(shengouren:String = "", shijian:String = "", message: String = "", repairid: String = ""){
        self.shengouren = shengouren
        self.shijian = shijian
        self.message = message
         self.repairid = repairid
        // super.init()
    }
    
    //从nsobject解析回来
    required init(coder decoder:NSCoder){
        self.shengouren = decoder.decodeObject(forKey: "shengouren") as! String
        self.shijian = decoder.decodeObject(forKey: "shijian") as! String
        self.message = decoder.decodeObject(forKey: "message")as! String
        self.repairid = decoder.decodeObject(forKey: "repairid")as! String
    }
    
    //编码成object
    func encode(with coder : NSCoder){
        coder.encode(shengouren,forKey:"shengouren")
        coder.encode(shijian,forKey:"shijian")
        coder.encode(message, forKey: "message")
        coder.encode(repairid, forKey: "repairid")
    }
}
