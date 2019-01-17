//
//  BaoxiuSearchList.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/17.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit

class BaoxiuSearchList: NSObject,NSCoding {
    var RepairID:String
    var EqptName:String
    var RepairState:String
    required init(RepairID:String = "", EqptName:String = "", RepairState: String = ""){
        self.RepairID = RepairID
        self.EqptName = EqptName
        self.RepairState = RepairState
        // super.init()
    }
    
    //从nsobject解析回来
    required init(coder decoder:NSCoder){
        self.RepairID = decoder.decodeObject(forKey: "RepairID") as! String
        self.EqptName = decoder.decodeObject(forKey: "EqptName") as! String
        self.RepairState = decoder.decodeObject(forKey: "RepairState")as! String
    }
    
    //编码成object
    func encode(with coder : NSCoder){
        coder.encode(RepairID,forKey:"RepairID")
        coder.encode(EqptName,forKey:"EqptName")
        coder.encode(RepairState, forKey: "RepairState")
    }
}
