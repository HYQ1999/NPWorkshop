//
//  ZhidaoList.swift
//  NPWorkshop
//
//  Created by 欧张帆 on 2019/1/17.
//  Copyright © 2019 韩意谦. All rights reserved.
//

import Foundation

class ZhidaoList: NSObject,NSCoding {
    var RepairMan:String
    var EqptName:String
    var RepairState:String
    required init(RepairMan:String = "", EqptName:String = "", RepairState: String = ""){
        self.RepairMan = RepairMan
        self.EqptName = EqptName
        self.RepairState = RepairState
        // super.init()
    }
    
    //从nsobject解析回来
    required init(coder decoder:NSCoder){
        self.RepairMan = decoder.decodeObject(forKey: "RepairMan") as! String
        self.EqptName = decoder.decodeObject(forKey: "EqptName") as! String
        self.RepairState = decoder.decodeObject(forKey: "RepairState")as! String
    }
    
    //编码成object
    func encode(with coder : NSCoder){
        coder.encode(RepairMan,forKey:"RepairMan")
        coder.encode(EqptName,forKey:"EqptName")
        coder.encode(RepairState, forKey: "RepairState")
    }
}
