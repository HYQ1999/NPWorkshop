//
//  Messages.swift
//  NPWorkshop
//
//  Created by 周旭 on 2019/1/15.
//  Copyright © 2019年 韩意谦. All rights reserved.
//

import Foundation
import ProgressHUD
class Messages: NSObject {
    var Code = [Int:String]()
    override init() {
        Code[0x1000] = "请输入用户名和密码"
        Code[0x1001] = "用户名或密码错误"
        Code[0x1002] = "无法连接服务器"
        Code[0x1003] = "登录失败"
        Code[0x1004] = "登录中"
        Code[0x1005] = "登录成功"
        Code[0x1006] = "没有该用户"
        Code[0x1007] = "该用户尚未启动"
        Code[0x1008] = "注册中"
        Code[0x1009] = "注册成功"
        Code[0x1010] = "用户名已存在"
        Code[0x1011] = "抢单成功"
        Code[0x1012] = "抢单失败"
        Code[0x1013] = "用户图片获取失败"
        Code[0x1014] = "获取用户图片中"
        Code[0x1015] = "个人信息修改成功"
        Code[0x1016] = "添加成功"
        Code[0x1017] = "添加失败"
        Code[0x1018] = "删除成功"
        Code[0x1019] = "删除失败"
        Code[0x1020] = "已完成"
        Code[0x1021] = "失败"
        Code[0x1022] = "该订单已完成"
        Code[0x1023] = "暂无评价"
        
        Code[0x2001] = "刷新中"
        Code[0x2002] = "刷新成功"
        Code[0x2003] = "刷新失败"
        Code[0x2004] = "加载中"
        Code[0x2005] = "上传中"
        Code[0x2006] = "上传成功"
        Code[0x2007] = "上传失败"
        Code[0x2008] = "获取权限失败"
        Code[0x2009] = "你还没有认证"
        
        Code[0x3000] = "请输入用户名"
        Code[0x3001] = "请输入密码"
        Code[0x3002] = "请输入公司名"
        Code[0x3003] = "验证码错误"
        Code[0x3004] = "请确认密码"
        
        Code[0x4001] = "正在连接"
    }
    
    
    func show(code: Int) {
        ProgressHUD.showSuccess(Code[code])

    }
    
    func showNow(code: Int){
        ProgressHUD.show(Code[code])
    }
    
    func showError(code: Int) {
        ProgressHUD.showError(Code[code])
    }
}

