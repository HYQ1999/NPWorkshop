//
//  Model_ManShengou.swift
//  NPWorkshop
//
//  Created by 欧张帆 on 2019/1/21.
//  Copyright © 2019 韩意谦. All rights reserved.
//

class Model_ManShengou: NSObject {
    
    
    class Response: NSObject {
        var ShengouId:String?
        var ShengouName:String?
        var ShengouQX:String?
     
        init(
            ShengouId: String?,
            ShengouName: String?,
            ShengouQX: String?
          
            ){
            self.ShengouId = ShengouId
            self.ShengouName = ShengouName
            self.ShengouQX = ShengouQX
           
        }
    }
}
