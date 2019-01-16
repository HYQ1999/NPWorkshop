//
//  Search.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/14.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit

//搜索时点击空白处隐藏键盘

protocol SearchTableViewDelegate {
    
    func hideKeyBoard()
    
}

class SearchTableView: UITableView {
    
    
    
    var mDelegate:SearchTableViewDelegate!
    
    required init?(coder aDecoder: NSCoder) {
    
        
        super.init(coder: aDecoder)
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
        if mDelegate != nil{
            
            mDelegate.hideKeyBoard()
            
        }
        
    }
    
}
