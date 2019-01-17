//
//  Models_PeiJianList.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/17.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit

class Models_PeiJianList: NSObject {

    
    class Response: NSObject {
        var PeiJianName:String?
        var PeiJianNum:String?
        var PeiJianLeibie:String?
        var PEiJIanDanJIa:String?
        init(
            PeiJianName: String?,
            PeiJianNum: String?,
            PeiJianLeibie: String?,
            PEiJIanDanJIa: String?
            ){
            self.PeiJianName = PeiJianName
            self.PeiJianNum = PeiJianNum
            self.PeiJianLeibie = PeiJianLeibie
             self.PEiJIanDanJIa = PEiJIanDanJIa
        }
    }
}
