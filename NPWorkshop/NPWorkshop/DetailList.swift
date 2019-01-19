//
//  DetailList.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/18.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit

class DetailList: NSObject,NSCoding {
    var Appearance:String
    var ApplyUser:String
    var AssetsNumber:String
    var BXUser:String
    var CancelReason:String
    var DeptName:String
    var EqptName:String
    var FinishTime:String
    var Laborcost:String
    var Parameter:String
    var Reason:String
    var RepairID:String
    var RepairState:String
    var RepairTime:String
    var RepairUser:String
    var Telphone:String
    var Total:String
    var Accepter:String
    required init(Appearance:String = "", ApplyUser:String = "", AssetsNumber: String = "", BXUser: String = "",CancelReason:String = "", DeptName:String = "", EqptName: String = "", FinishTime: String = "",Laborcost:String = "", Parameter:String = "", Reason: String = "", RepairID: String = "",RepairState: String = "",RepairTime:String = "", RepairUser:String = "", Telphone: String = "", Total: String = "",Accepter: String = ""){
        self.Appearance = Appearance
        self.ApplyUser = ApplyUser
        self.AssetsNumber = AssetsNumber
        self.BXUser = BXUser
        self.CancelReason = CancelReason
        self.DeptName = DeptName
        self.EqptName = EqptName
        self.FinishTime = FinishTime
        self.Laborcost = Laborcost
        self.Parameter = Parameter
        self.Reason = Reason
        self.RepairID = RepairID
        self.RepairState = RepairState
        self.RepairTime = RepairTime
        self.RepairUser = RepairUser
        self.Telphone = Telphone
        self.Total = Total
        self.Accepter = Accepter
        // super.init()
    }
    
    //从nsobject解析回来
    required init(coder decoder:NSCoder){
        self.Appearance = (decoder.decodeObject(forKey: "Appearance")as? String ?? nil)!
        self.ApplyUser = (decoder.decodeObject(forKey: "ApplyUser")as? String ?? nil)!
        self.AssetsNumber = (decoder.decodeObject(forKey: "AssetsNumber")as? String ?? nil)!
        self.BXUser = (decoder.decodeObject(forKey: "BXUser")as? String ?? nil)!
        self.CancelReason = (decoder.decodeObject(forKey: "CancelReason")as? String ?? nil)!
        self.DeptName = (decoder.decodeObject(forKey: "DeptName")as? String ?? nil)!
        self.EqptName = (decoder.decodeObject(forKey: "EqptName")as? String ?? nil)!
        self.FinishTime = (decoder.decodeObject(forKey: "FinishTime")as? String ?? nil)!
        self.Laborcost = (decoder.decodeObject(forKey: "Laborcost")as? String ?? nil)!
        self.Parameter = (decoder.decodeObject(forKey: "Parameter")as? String ?? nil)!
        self.Reason = (decoder.decodeObject(forKey: "Reason")as? String ?? nil)!
        self.RepairID = (decoder.decodeObject(forKey: "RepairID")as? String ?? nil)!
        self.RepairState = (decoder.decodeObject(forKey: "RepairState")as? String ?? nil)!
        self.RepairTime = (decoder.decodeObject(forKey: "RepairTime")as? String ?? nil)!
        self.RepairUser = (decoder.decodeObject(forKey: "RepairUser")as? String ?? nil)!
        self.Telphone = (decoder.decodeObject(forKey: "Telphone")as? String ?? nil)!
        self.Total = (decoder.decodeObject(forKey: "Total")as? String ?? nil)!
        self.Accepter = (decoder.decodeObject(forKey: "Accepter")as? String ?? nil)!
    }
    
    //编码成object
    func encode(with coder : NSCoder){
        coder.encode(Appearance,forKey:"Appearance")
        coder.encode(ApplyUser,forKey:"ApplyUser")
        coder.encode(AssetsNumber, forKey: "AssetsNumber")
        coder.encode(BXUser, forKey: "BXUser")
        coder.encode(CancelReason,forKey:"CancelReason")
        coder.encode(DeptName,forKey:"DeptName")
        coder.encode(EqptName, forKey: "EqptName")
        coder.encode(FinishTime, forKey: "FinishTime")
        coder.encode(Laborcost,forKey:"Laborcost")
        coder.encode(Parameter,forKey:"Parameter")
        coder.encode(Reason, forKey: "Reason")
        coder.encode(RepairID, forKey: "RepairID")
        coder.encode(RepairState,forKey:"RepairState")
        coder.encode(RepairTime,forKey:"RepairTime")
        coder.encode(RepairUser, forKey: "RepairUser")
        coder.encode(Telphone, forKey: "Telphone")
        coder.encode(Total, forKey: "Total")
        coder.encode(Accepter, forKey: "Accepter")
    }
}
