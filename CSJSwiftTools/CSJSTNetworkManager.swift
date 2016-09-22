//
//  CSJSTNetworkManager.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/15.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

typealias NetworkCallbackBlock = (JSON?, NetworkErrorType?) -> Void

enum NetworkErrorType: Error, CustomStringConvertible {
    
    case networkUnreachable(String) // Timeout or Unreachable
    case networkUnauthenticated(String) // 401 or 403
    case networkServerError(String) // 5XX
    case networkForbiddenAccess(String) // 400 or 404
    case networkWrongParameter(String) // 422
    
    init(stringLiteral value: StringLiteralType) {
        switch value {
        case "NetworkUnreachable":
            self = .networkUnreachable(value)
        case "NetworkUnauthenticated":
            self = .networkUnauthenticated(value)
        case "NetworkServerError":
            self = .networkServerError(value)
        case "NetworkWrongParameter":
            self = .networkWrongParameter(value)
        default:
            self = .networkForbiddenAccess(value)
        }
    }
    
    var description: String {
        get {
            switch self {
            case .networkUnreachable(_):
                return "Timeout or Unreachable"
//                return message
            case .networkUnauthenticated(let message):
                return message
            case .networkServerError(let message):
                return message
            case .networkForbiddenAccess(let message):
                return message
            case .networkWrongParameter(let message):
                return message
            }
        }
    }
}

class CSJSTNetworkManager: NSObject {
    
    static let sharedInstance = CSJSTNetworkManager()
    
    //csj第一步 =。=
    fileprivate struct Constants {
        static let LoginMima              = "LoginMima"
        static let UpdateChannel = "Update Channel"
    }
    
    fileprivate static var PendingOpDict = [String : (Request, Date)]()
    
    /**
     Execute the network request
     
     - parameter key:      unique string in caching dictionary
     - parameter request:  request (or value) in caching dictionary
     - parameter callback: a block executed when network request finished
     */
    fileprivate class func executeRequestWithKey(_ key: String, request: Request, callback: NetworkCallbackBlock) {
        print("网络请求 = \(key)")
        // Add a new item in the caching dictionary
        PendingOpDict[key] = (request, Date())
        // Executing request
        request.responseJSON { (response) in
            let (response, result) = (response.response, response.result)
            let statusCode = response?.statusCode ?? 404
            
            var json: JSON?
            var error: NetworkErrorType?
            //            print("error = \(error)")
            // Remove the item the caching dictionary
            PendingOpDict.removeValueForKey(key)
            //jsonmessage
            //            let message = JSON(result.value!)["statusMessage"].string
            //            print("message = \(message)")
            // Deal with statusCode and JSON from server
            if case (200..<300) = statusCode {
                print("error all = \(statusCode)")
                let value = result.value ?? NSData()
                if JSON(value)["statusCode"].string == "0" {
                    json = {
                        var json = JSON(value)
                        json["token"].string = response?.allHeaderFields["token"] as? String
                        return json
                    }()
                } else {
                    error = NetworkErrorType(stringLiteral: JSON(value)["statusMessage"].stringValue)
                }
            } else {
                if result.isFailure {
                    error = NetworkErrorType.NetworkUnreachable("\(result.error)")
                }
                else if let value = result.value {
                    let message = JSON(value)["statusMessage"].string
                    
                    if statusCode == 403 || statusCode == 401 {
                        error = NetworkErrorType.NetworkUnauthenticated(message ?? "Unauthenticated access statusCode = \(statusCode)")
                    } else if statusCode == 400 || statusCode == 404 {
                        error = NetworkErrorType.NetworkForbiddenAccess(message ?? "Bad request statusCode = \(statusCode)")
                    } else if case(400..<500) = statusCode {
                        error = NetworkErrorType.NetworkWrongParameter(message ?? "Wrong parameters statusCode = \(statusCode)")
                    } else if case(500...505) = statusCode {
//                        error = NetworkErrorType.NetworkServerError(message ?? "Server error \(statusCode)")
                        error = NetworkErrorType.NetworkServerError("statusCode = \(statusCode),网络连接失败")
                    }
                }
            }
            // execute the block
            callback(json, error)
        }
    }
    
    /** 
     form-data传送数据
     */
    fileprivate class func executeRequestWithKey_FromData(_ key: String, request: Request, callback: NetworkCallbackBlock) {
        print("网络请求 = \(key)")
        // Add a new item in the caching dictionary
//        PendingOpDict[key] = (request, NSDate())
        
        request.validate(statusCode: 200..<300)
        // Executing request
        request.responseJSON { (response) in
            let (response, result) = (response.response, response.result)
            var json: JSON?
            var error: NetworkErrorType?
            let statusCode = response?.statusCode ?? 404
            
            if (result.error == nil) {
                let value = result.value ?? NSData()
                print("response.response = \(response)")
                json = JSON(value)
            } else {
                if result.isFailure {
                    error = NetworkErrorType.NetworkUnreachable("\(result.error)")
                }
                else if let value = result.value {
                    let message = JSON(value)["statusMessage"].string
                    
                    if statusCode == 403 || statusCode == 401 {
                        error = NetworkErrorType.NetworkUnauthenticated(message ?? "Unauthenticated access statusCode = \(statusCode)")
                    } else if statusCode == 400 || statusCode == 404 {
                        error = NetworkErrorType.NetworkForbiddenAccess(message ?? "Bad request statusCode = \(statusCode)")
                    } else if case(400..<500) = statusCode {
                        error = NetworkErrorType.NetworkWrongParameter(message ?? "Wrong parameters statusCode = \(statusCode)")
                    } else if case(500...505) = statusCode {
                        //                        error = NetworkErrorType.NetworkServerError(message ?? "Server error \(statusCode)")
                        error = NetworkErrorType.NetworkServerError("statusCode = \(statusCode),网络连接失败")
                    }
                }
            }
            // execute the block
            callback(json, error)
        }
    }
    
    // Default network manager, timeout set to 10s
    fileprivate static let Manager: Alamofire.Manager = {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 10.0
        return Alamofire.Manager(configuration: configuration, serverTrustPolicyManager: nil)
    }()
    
    
    class func existPendingOperation(_ key: String) -> Bool {
        return PendingOpDict[key] != nil
    }
}


extension CSJSTNetworkManager{
    enum Router: URLRequestConvertible {
//        static let baseURLString = ""
        //MARK: - 添加服务器基础地址 -
        //正式
//        static let baseURLString = ""
        
        //测试
//        static let baseURLString = ""
        
        //开发
        static let baseURLString = ""
        
        
        
        static var OAuthToken: String?
        
        //    case LoginMima(String, String, String)
        case loginMima([String: AnyObject])
        case updateChannel([String: AnyObject])
        
        var method: HTTPMethod {
            switch self {
            case .loginMima:
                return .post
            case .updateChannel:
                return .post
            
            }
        }
        
        var path: String {
            switch self {
            case .loginMima:
                return "/user/login"
            
            case .updateChannel:
            return "/api-front/payment/update-channel"
            }
        }
    
        // MARK: URLRequestConvertible
        var URLRequest: NSMutableURLRequest {
//            (inout parameters: [String: AnyObject]) in
            let URL = Foundation.URL(string: Router.baseURLString)!
            let mutableURLRequest = NSMutableURLRequest(url: URL.appendingPathComponent(path))
            mutableURLRequest.HTTPMethod = method.rawValue
            
            if let token = Router.OAuthToken {
                mutableURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            
            switch self {
            case .loginMima(let parameters):
                return ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
            case .updateChannel(let parameters):
                return ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters).0
                /*
                 case .CreateUser(let parameters):
                 return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
                 case .UpdateUser(_, let parameters):
                 return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters).0
                 */
//            default:
//                return mutableURLRequest
            }
        }
        
    }
    
    
    /**
     发起一个POST请求，Body是JSON形式的
     */
    func loginMima(_ parameters: [String : AnyObject],callback : NetworkCallbackBlock){
        guard !CSJSTNetworkManager.existPendingOperation(Constants.LoginMima) else {
            return
        }
        let request = CSJSTNetworkManager.Manager.request(Router.LoginMima(parameters))
        CSJSTNetworkManager.executeRequestWithKey(Constants.LoginMima, request: request, callback: callback)
    }
    
    
    /**
     发起一个POST请求，Body是Form URL-Encoded形式的
     */
    func sendRequest2(_ body:[String : AnyObject], callback : NetworkCallbackBlock) {
        guard !CSJSTNetworkManager.existPendingOperation(Constants.UpdateChannel) else {
            return
        }
        let request = CSJSTNetworkManager.Manager.request(Router.UpdateChannel(body))
        CSJSTNetworkManager.executeRequestWithKey_FromData(Constants.UpdateChannel, request: request, callback: callback)
    }
    
    
    
    
    
    
    
    
    
    
    
    /************************** 我是分割线 ****************************/
    /************************** 下面方法放弃 ****************************/

    
    
    func sendRequest_JSON(_ body:[String : AnyObject], callback : NetworkCallbackBlock) {
        // Add Headers
        let headers = [
            "Content-Type":"application/json",
            ]
        // JSON Body
        // Fetch Request
        Alamofire.request("\(Router.baseURLString)/user/login", method: HTTPMethod.post, parameters: body, encoding: .json)
//        Alamofire.request(.POST, "\(Router.baseURLString)/user/login", headers: headers, parameters: body, encoding: .JSON)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                let (response, result, data) = (response.response, response.result, response.data)
                var json: JSON?
                var error: NetworkErrorType?
                let statusCode = response?.statusCode ?? 404
                
                if (result.error == nil) {
                    let value = result.value ?? NSData()
                    print("response.response = \(response)")
                    json = JSON(value)
                    
                    debugPrint("HTTP Response Body: \(data)")
                }
                else {
                    if result.isFailure {
                        error = NetworkErrorType.networkUnreachable("\(result.error)")
                    }
                    else if let value = result.value {
                        let message = JSON(value)["statusMessage"].string
                        
                        if statusCode == 403 || statusCode == 401 {
                            error = NetworkErrorType.NetworkUnauthenticated(message ?? "Unauthenticated access statusCode = \(statusCode)")
                        } else if statusCode == 400 || statusCode == 404 {
                            error = NetworkErrorType.NetworkForbiddenAccess(message ?? "Bad request statusCode = \(statusCode)")
                        } else if case(400..<500) = statusCode {
                            error = NetworkErrorType.NetworkWrongParameter(message ?? "Wrong parameters statusCode = \(statusCode)")
                        } else if case(500...505) = statusCode {
                            //                        error = NetworkErrorType.NetworkServerError(message ?? "Server error \(statusCode)")
                            error = NetworkErrorType.NetworkServerError("statusCode = \(statusCode),网络连接失败")
                        }
                    }
                    
                    debugPrint("HTTP Request failed: \(result.error)")
                }
                
                callback(json, error)
        }
    }
    
}




/************************** 弃用分割线 ****************************/


/**
 发起一个POST请求，Body是Form URL-Encoded形式的
 */
/*
func sendRequest(let body:[String : AnyObject], callback : NetworkCallbackBlock) {
//     微信支付宝信息获取接口
//     POST http:139.196.240.36:8080/api-front/payment/update-channel
    
    // Add Headers
    let headers = [
        "Content-Type":"application/x-www-form-urlencoded; charset=utf-8",
        ]
    // Form URL-Encoded Body
    
    // Fetch Request
    Alamofire.request(.POST, "\(Router.baseURLString)/api-front/payment/update-channel", headers: headers, parameters: body, encoding: .URL)
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            let (response, result, data) = (response.response, response.result, response.data)
            var json: JSON?
            var error: NetworkErrorType?
            let statusCode = response?.statusCode ?? 404
            
            if (result.error == nil) {
                let value = result.value ?? NSData()
                print("response.response = \(response)")
                //                    if JSON(value)["statusCode"].string == "0" {
                json = JSON(value)
                debugPrint("HTTP Response Body: \(data)")
            }
            else {
                if result.isFailure {
                    error = NetworkErrorType.NetworkUnreachable("\(result.error)")
                }
                else if let value = result.value {
                    let message = JSON(value)["statusMessage"].string
                    
                    if statusCode == 403 || statusCode == 401 {
                        error = NetworkErrorType.NetworkUnauthenticated(message ?? "Unauthenticated access statusCode = \(statusCode)")
                    } else if statusCode == 400 || statusCode == 404 {
                        error = NetworkErrorType.NetworkForbiddenAccess(message ?? "Bad request statusCode = \(statusCode)")
                    } else if case(400..<500) = statusCode {
                        error = NetworkErrorType.NetworkWrongParameter(message ?? "Wrong parameters statusCode = \(statusCode)")
                    } else if case(500...505) = statusCode {
                        //                        error = NetworkErrorType.NetworkServerError(message ?? "Server error \(statusCode)")
                        error = NetworkErrorType.NetworkServerError("statusCode = \(statusCode),网络连接失败")
                    }
                }
                
                debugPrint("HTTP Request failed: \(result.error)")
            }
            
            callback(json, error)
    }
}
*/


/**
 let parameters = [
 "foo": "bar",
 "baz": ["a", 1],
 "qux": [
 "x": 1,
 "y": 2,
 "z": 3
 ]
 ]
 */
