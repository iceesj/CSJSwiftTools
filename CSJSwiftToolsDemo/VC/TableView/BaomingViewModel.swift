//
//  BaomingViewModel.swift
//  xs1happ
//
//  Created by iceesj on 16/5/24.
//  Copyright © 2016年 xs1h. All rights reserved.
//

import UIKit

enum BaomingStatus : CustomStringConvertible {
    case login, noLogin
    
    var description: String {
        switch self {
        case .login:
            return "注册"
        case .noLogin:
            return "没注册"
        }
    }
    
    var boolValue: Bool {
        switch self {
        case .login:
            return true
        case .noLogin:
            return false
        }
    }
}

class BaomingViewModel {
    let BaomingViewModel = [
        BaomingStatus.login: [
            (cellIdentifier: "Button Cell", placeHolder: "请输入手机号"),
            (cellIdentifier: "Text Two Cell", placeHolder: "请输入短信中的验证码"),
            (cellIdentifier: "Text Name Cell", placeHolder: "请输入姓名"),
            (cellIdentifier: "Text Sex Cell", placeHolder: ""),
            (cellIdentifier: "Text GS Cell", placeHolder: "请输入公司名称")
        ],
        BaomingStatus.noLogin: [
            (cellIdentifier: "Text PhoneNum Cell", placeHolder: ""),
            (cellIdentifier: "Text Name Cell", placeHolder: "请输入姓名"),
            (cellIdentifier: "Text Sex Cell", placeHolder: ""),
            (cellIdentifier: "Text GS Cell", placeHolder: "请输入公司名称")
        ]
    ]
    
    let validators = [
        BaomingStatus.login: [
            (validator: String.isValidPhoneNumber, prompt: "请输入正确的手机号"),
//            (validator: String.isSecureCode, prompt: "请输入正确的验证码")
            
        ],
        BaomingStatus.noLogin: [
//            (validator: String.isUserName, prompt: "用户名过长或含有非法字符"),
//            (validator: String.isValidPhoneNumber, prompt: "请输入正确的手机号"),
//            (validator: String.isSecureCode, prompt: "请输入正确的验证码")
        ]
    ]
    
    func validator(_ x: BaomingStatus, _ y: Int) -> (validator: (String) -> () -> Bool, prompt: String) {
        guard y >= 0 && y < (validators[x]?.count ?? 0) else {return (validator: String.isNonEmpty, prompt: "Error")}
        return validators[x]![y]
    }
    
    subscript(x: BaomingStatus) -> Int {
        get {
            return BaomingViewModel[x]?.count ?? 0
        }
    }
    
    subscript(x: BaomingStatus, y: Int) -> (cellIdentifier: String, placeHolder: String)? {
        get {
            guard y >= 0 && y < (BaomingViewModel[x]?.count ?? 0) else {return nil}
            return BaomingViewModel[x]?[y]
        }
    }
    
}
