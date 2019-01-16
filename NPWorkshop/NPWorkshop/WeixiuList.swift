//
//  WeixiuList.swift
//  NPWorkshop
//
//  Created by 欧张帆 on 2019/1/16.
//  Copyright © 2019 韩意谦. All rights reserved.
//

import Foundation

class WeixiuList: NSObject,NSCoding {
    var FixID:String
    var EqptName:String
    var FixState:String
    required init(FixID:String = "", EqptName:String = "", FixState: String = ""){
        self.FixID = FixID
        self.EqptName = EqptName
        self.FixState = FixState
        // super.init()
    }
    
    //从nsobject解析回来
    required init(coder decoder:NSCoder){
        self.FixID = decoder.decodeObject(forKey: "FixID") as! String
        self.EqptName = decoder.decodeObject(forKey: "EqptName") as! String
        self.FixState = decoder.decodeObject(forKey: "FixState")as! String
    }
    
    //编码成object
    func encode(with coder : NSCoder){
        coder.encode(FixID,forKey:"FixID")
        coder.encode(EqptName,forKey:"EqptName")
        coder.encode(FixState, forKey: "FixState")
    }
}

