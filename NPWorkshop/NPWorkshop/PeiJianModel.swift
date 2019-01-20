//
//  PeiJianModel.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/17.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import UIKit

class PeiJianModel: NSObject {
    
    var pjlist = [Peijianllist]()
    
    override init(){
        super.init()
        print("沙盒文件夹路径：\(documentsDirectory())")
        //沙盒路径："/Users/abc/Library/Developer/CoreSimulator/Devices/741303D5-782E-483C-B6FB-91A473EB90CF/data/Containers/Data/Application/5A84E819-0FCF-4F5F-A057-A570B95FD908"
        print("数据文件路径：\(dataFilePath())")
    }
    
    //保存数据
    func saveData() {
        let data = NSMutableData()
        //申明一个归档处理对象
        let archiver = NSKeyedArchiver(forWritingWith: data)
        //将lists以对应Checklist关键字进行编码
        archiver.encode(pjlist, forKey: "pjlist")
        //编码结束
        archiver.finishEncoding()
        //数据写入
        data.write(toFile: dataFilePath(), atomically: true)
    }
    
    //读取数据
    func loadData() {
        //获取本地数据文件地址
        let path = self.dataFilePath()
        //声明文件管理器
        let defaultManager = FileManager()
        //通过文件地址判断数据文件是否存在
        if defaultManager.fileExists(atPath: path) {
            //读取文件数据
            let url = URL(fileURLWithPath: path)
            let data = try! Data(contentsOf: url)
            //解码器
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            //通过归档时设置的关键字Checklist还原lists
            pjlist = unarchiver.decodeObject(forKey: "pjlist") as! Array
            //结束解码
            unarchiver.finishDecoding()
        }
    }
    
    //获取沙盒文件夹路径
    func documentsDirectory()->String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                        .userDomainMask, true)
        let documentsDirectory = paths.first!
        return documentsDirectory
    }
    
    //获取数据文件地址
    func dataFilePath ()->String{
        return self.documentsDirectory().appendingFormat("/Peijianlist.plist")
    }
}
