//
//  DetailList.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/18.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit

class DetailList: NSObject {
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
    var TotalCost:String
    required init(Appearance:String = "", ApplyUser:String = "", AssetsNumber: String = "", BXUser: String = "",CancelReason:String = "", DeptName:String = "", EqptName: String = "", FinishTime: String = "",Laborcost:String = "", Parameter:String = "", Reason: String = "", RepairID: String = "",RepairState: String = "",RepairTime:String = "", RepairUser:String = "", Telphone: String = "", Total: String = "", TotalCost: String = ""){
        self.Appearance = Appearance
        self.ApplyUser = ApplyUser
        self.AssetsNumber = AssetsNumber
        self.BXUser = BXUser
        self.CancelReason = Appearance
        self.DeptName = ApplyUser
        self.EqptName = AssetsNumber
        self.FinishTime = BXUser
        self.Laborcost = Appearance
        self.Parameter = ApplyUser
        self.Reason = AssetsNumber
        self.RepairID = BXUser
        self.RepairState = Appearance
        self.RepairTime = ApplyUser
        self.RepairUser = AssetsNumber
        self.Telphone = BXUser
        self.Total = AssetsNumber
        self.TotalCost = BXUser
        // super.init()
    }
    
    //从nsobject解析回来
    required init(coder decoder:NSCoder){
        self.Appearance = decoder.decodeObject(forKey: "Appearance") as! String
        self.ApplyUser = decoder.decodeObject(forKey: "ApplyUser") as! String
        self.AssetsNumber = decoder.decodeObject(forKey: "AssetsNumber")as! String
        self.BXUser = decoder.decodeObject(forKey: "BXUser")as! String
        self.CancelReason = decoder.decodeObject(forKey: "CancelReason") as! String
        self.DeptName = decoder.decodeObject(forKey: "DeptName") as! String
        self.EqptName = decoder.decodeObject(forKey: "EqptName")as! String
        self.FinishTime = decoder.decodeObject(forKey: "FinishTime")as! String
        self.Laborcost = decoder.decodeObject(forKey: "Laborcost") as! String
        self.Parameter = decoder.decodeObject(forKey: "Parameter") as! String
        self.Reason = decoder.decodeObject(forKey: "Reason")as! String
        self.RepairID = decoder.decodeObject(forKey: "RepairID")as! String
        self.RepairState = decoder.decodeObject(forKey: "RepairState") as! String
        self.RepairTime = decoder.decodeObject(forKey: "RepairTime") as! String
        self.RepairUser = decoder.decodeObject(forKey: "RepairUser")as! String
        self.Telphone = decoder.decodeObject(forKey: "Telphone")as! String
        self.Total = decoder.decodeObject(forKey: "Total")as! String
        self.TotalCost = decoder.decodeObject(forKey: "TotalCost")as! String
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
        coder.encode(TotalCost, forKey: "TotalCost")
    }
}
