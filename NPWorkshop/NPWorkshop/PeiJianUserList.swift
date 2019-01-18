//
//  PeiJianUserList.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/18.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit

class PeiJianUserList: NSObject {
    var peijianminchen:String
    var peijiannum:String
    var peijianmoney:String
    var peijiantotal:String
    required init(peijianminchen:String = "", peijiannum:String = "", peijianmoney: String = "", peijiantotal: String = ""){
        self.peijianminchen = peijianminchen
        self.peijiannum = peijiannum
        self.peijianmoney = peijianmoney
        self.peijiantotal = peijiantotal
        // super.init()
    }
    
    //从nsobject解析回来
    required init(coder decoder:NSCoder){
        self.peijianminchen = decoder.decodeObject(forKey: "peijianminchen") as! String
        self.peijiannum = decoder.decodeObject(forKey: "peijiannum") as! String
        self.peijianmoney = decoder.decodeObject(forKey: "peijianmoney")as! String
        self.peijiantotal = decoder.decodeObject(forKey: "peijiantotal")as! String
    }
    
    //编码成object
    func encode(with coder : NSCoder){
        coder.encode(peijianminchen,forKey:"peijianminchen")
        coder.encode(peijiannum,forKey:"peijiannum")
        coder.encode(peijianmoney, forKey: "peijianmoney")
        coder.encode(peijiantotal, forKey: "peijiantotal")
    }
}
