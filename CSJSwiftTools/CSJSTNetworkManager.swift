//
//  CSJSTNetworkManager.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/15.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit
//import Alamofire
import SVProgressHUD
import MBProgressHUD
//import SnapKit
//import MJExtension
import ObjectMapper
import Alamofire
import SwiftyJSON

let ajmapp_downloadurl = "https://itunes.apple.com/us/app/"


typealias NetworkCallbackBlock = (JSON?, NetworkErrorType?) -> Void
typealias URLSessionCallbackBlock = (JSON, String) -> Void

typealias ResponseBlock = (_ response:Any, _ success:Bool)->Void

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

//MARK: NSURLSession
class CSJSTNetworkManager : NSObject{
    static let shared = CSJSTNetworkManager()
    //正式
    static let baseURLString = ""
    //测试
//    static let baseURLString = ""
    //开发
//    static let baseURLString = ""
    
    /****** alamofire 4 *****/
    //MARK: 创建session
    func getSession(callback : @escaping ResponseBlock) {
        //iOS 8
        /*
         CSJSTNetworkManager.shared.postURLParamsOnly("/api-store/session/create",[:]){
         (swiftyJsonVar, error) in
         let resultDic = swiftyJsonVar["result"].stringValue
         print("resultDic = \(resultDic)")
         
         }
         */
        Alamofire.request("\(CSJSTNetworkManager.baseURLString)/api-store/session/create", method: .post)
            .responseJSON { response in
                if (response.result.error == nil) {
                    let value = response.result.value ?? Data()
                    let swiftyJsonVar = JSON(value)
                    let resultDic = swiftyJsonVar["result"].stringValue
                    //                    print("创建session resultDic = \(resultDic)")
                    
                    callback(resultDic, true)
                }else{
                    SVProgressHUD.dismiss()
                    debugPrint("创建session HTTP Request failed: \(String(describing: response.result.error))")
                    print("创建session \(String(describing: response.response?.statusCode))")
                    callback(response.response?.statusCode ?? "", false)
                }
        }
    }
    
    //MARK: 退出登录
    func logout(vc:UIViewController, callback : @escaping ResponseBlock){
        let URLParams = [
            "sessionId": "",
            "version": CSJSwiftToolsDirector.sharedInstance.versionNumber(),
            "device": "",
            ]
        Alamofire.request("\(CSJSTNetworkManager.baseURLString)/api-store/session/logout", method: .post, parameters: URLParams)
            .responseJSON { response in
                if (response.result.error == nil) {
                    let value = response.result.value ?? Data()
                    let swiftyJsonVar = JSON(value)
                    let status = swiftyJsonVar["status"].stringValue
                    print("status = \(status)")
                    if status == "OK"{
                        vc.promptLoginViewController()
//                        ContentManager.sharedInstance.clearConfidential()
//                        ContentManager.sharedInstance.clearStoreInfo()
                    }else{
//                        CSJSTHUD.showWithStatus("退出登录失败", onView: vc.view)
                    }
                    callback(status, true)
                }else{
                    SVProgressHUD.dismiss()
//                    MBProgressHUD.showWithStatus(GlobalConstants.ajm_wangluowenti, onView:vc.view)
                    debugPrint("创建session HTTP Request failed: \(String(describing: response.result.error))")
                    print("创建session \(String(describing: response.response?.statusCode))")
                    callback(response.response?.statusCode ?? "", false)
                }
        }
    }
    
    //MARK：URL Params
    //MARK: Get URL Params 有参数
    func getURLParams(_ string: String, _ body:[String : Any], callback : @escaping (JSON, Error?) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        /* Create session, and optionally set a NSURLSessionDelegate. */
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
//        let urlString = "\(CSJSTNetworkManager.baseURLString)/api-front/session/get-user-info"
        
        ///*
        let urlString = "\(CSJSTNetworkManager.baseURLString)\(string)"
        print("urlstring = \(urlString)")
        guard var URL = URL(string: urlString) else {return}
        URL = URL.URLByAppendingQueryParameters(body) as URL
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        //*/
        /*
        guard let URL = URL(string: urlString) else {return}
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        let bodyString = body.queryParameters
        request.httpBody = bodyString.data(using: String.Encoding.utf8, allowLossyConversion: true)
        */
        /* Start a new Task */
        var swiftyJsonVar: JSON!
//        var errorInt = ""
        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
            
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                swiftyJsonVar = JSON(data: data!)
//                print("swiftyJsonVar = \(swiftyJsonVar)")
                callback(swiftyJsonVar, nil)
            }else{
//                print("error.debugDescription = \(error.debugDescription)")
                let (domain, code, errorString) = (error!._domain, error!._code, error!.localizedDescription)
                print("domain = \(domain) , errorCode = \(code), URL Session Task Failed: \(errorString)")
                callback("", error!)
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    //MARK: GET URL Params 无参数
    func getURLParamsOnly(_ urlString: String, _ body:[String : Any], callback : @escaping URLSessionCallbackBlock) {
        
    }
    
    //MARK: POST
    //MARK: POST URL Params 无参数
    func postURLParamsOnly(_ string: String, _ body:[String : Any], callback : @escaping URLSessionCallbackBlock) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        let urlString = "\(CSJSTNetworkManager.baseURLString)\(string)"
        print("urlstring = \(urlString)")
        guard let URL = URL(string: urlString) else {return}
        var request = URLRequest(url: URL)
        request.httpMethod = "POST"
        
        /* Start a new Task */
        var swiftyJsonVar: JSON!
        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                swiftyJsonVar = JSON(data: data!)
                callback(swiftyJsonVar, "")
            }
            else {
                // Failure
                let (domain, code, errorString) = (error!._domain, error!._code, error!.localizedDescription)
                print("domain = \(domain) , errorCode = \(code), URL Session Task Failed: \(errorString)")
                callback("", errorString)
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    
    //MARK: POST URL Params 有参数
    func postURLParams(_ string: String, _ body:[String : Any], callback : @escaping URLSessionCallbackBlock) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let urlString = "\(CSJSTNetworkManager.baseURLString)\(string)"
        
        guard var URL = URL(string: urlString) else {return}
        URL = URL.URLByAppendingQueryParameters(body) as URL
        var request = URLRequest(url: URL)
        request.httpMethod = "POST"
        // Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        /* Start a new Task */
        var swiftyJsonVar: JSON!
        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                swiftyJsonVar = JSON(data: data!)
                callback(swiftyJsonVar, "")
            }
            else {
                // Failure
                let (domain, code, errorString) = (error!._domain, error!._code, error!.localizedDescription)
                print("domain = \(domain) , errorCode = \(code), URL Session Task Failed: \(errorString)")
                callback("", errorString)
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
        
    }
    
    
    //MARK: JSON
    //MARK: GET JSON 有body 有header
    func getJSONParams(_ string : String, _ body : [String : Any], callback : @escaping URLSessionCallbackBlock) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let urlString = "\(CSJSTNetworkManager.baseURLString)\(string)"
        
        guard let URL = URL(string: urlString) else {return}
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        // Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("0a9aacfe-5327-462a-9852-d09210a8c2b9", forHTTPHeaderField: "token")
        // JSON Body
        let bodyObject = body
        request.httpBody = try! JSONSerialization.data(withJSONObject: bodyObject, options: [])
        
        /* Start a new Task */
        var swiftyJsonVar: JSON!
        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                swiftyJsonVar = JSON(data: data!)
                callback(swiftyJsonVar, "")
            }
            else {
                // Failure
                let (domain, code, errorString) = (error!._domain, error!._code, error!.localizedDescription)
                print("domain = \(domain) , errorCode = \(code), URL Session Task Failed: \(errorString)")
                callback("", errorString)
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
        
    }
    
    
    
}

protocol URLQueryParameterStringConvertible {
    var queryParameters: String {get}
}

extension Dictionary : URLQueryParameterStringConvertible {
    /**
     This computed property returns a query parameters string from the given NSDictionary. For
     example, if the input is @{@"day":@"Tuesday", @"month":@"January"}, the output
     string will be @"day=Tuesday&month=January".
     @return The computed parameters string.
     */
    var queryParameters: String {
        var parts: [String] = []
        //stringByAddingPercentEncodingWithAllowedCharacters，，URLQueryAllowedCharacterSet
        for (key, value) in self {
            let part = NSString(format: "%@=%@",
                                String(describing: key).addingPercentEncoding(withAllowedCharacters:(NSCharacterSet.urlQueryAllowed))!,
                                String(describing: value).addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
    
}

extension URL {
    /**
     Creates a new URL by adding the given query parameters.创建一个新的URL添加给定的查询参数
     @param parametersDictionary The query parameter dictionary to add. 字典添加查询参数
     @return A new NSURL. 返回一个NSURL
     */
    func URLByAppendingQueryParameters(_ parametersDictionary : Dictionary<String, Any>) -> NSURL {
        let URLString : NSString = NSString(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
        return NSURL(string: URLString as String)!
    }
}



/********************************** Alamofire **********************************/
/********************************** Alamofire **********************************/
/********************************** Alamofire **********************************/




//MARK: Alamofire 4
class CSJAlamofire: NSObject {
    static let sharedInstance = CSJAlamofire()
    
    /*
    func postJSON(_ string : String,_ methodString: Alamofire.HTTPMethod,_ body: [String : Any], callback : @escaping NetworkCallbackBlock){
//        let headers = ["Content-Type":"application/x-www-form-urlencoded; charset=utf-8",]
        print("body2 = \(body)")
        
        print("methodString = \(methodString)")
        
        Alamofire.request(string, method: .post, parameters: body, encoding: JSONEncoding.default)
//        Alamofire.request("\(CSJSTNetworkManager.baseURLString)\(string)", method: .post, parameters: body, encoding: .url, headers: headers)
//            .validate(statusCode: 200..<300)
            .responseJSON { response in
                let (response, result) = (response.response, response.result)
                let statusCode = response?.statusCode ?? 404
                var json: JSON?
                var error: NetworkErrorType?
//                if (response.result.error == nil) {
//                }
                if case (200..<300) = statusCode {
                    print("alamofire 成功请求Code = \(statusCode)")
                    let value = result.value ?? Data()
                    json = JSON(value)
//                    print("swiftyJsonVar = \(json)")
                } else {
                    if result.isFailure {
                        error = NetworkErrorType.networkUnreachable("\(result.error)")
                    } else if let value = result.value {
                        let message = JSON(value)["statusMessage"].string
                        if statusCode == 403 || statusCode == 401 {
                            error = NetworkErrorType.networkUnauthenticated(message ?? "Unauthenticated access \(statusCode)")
                        } else if statusCode == 400 || statusCode == 404 {
                            error = NetworkErrorType.networkForbiddenAccess(message ?? "Bad request \(statusCode)")
                        } else if case(400..<500) = statusCode {
                            error = NetworkErrorType.networkWrongParameter(message ?? "Wrong parameters \(statusCode)")
                        } else if case(500...505) = statusCode {
//                        error = NetworkErrorType.NetworkServerError(message ?? "Server error \(statusCode)")
                            error = NetworkErrorType.networkServerError("网络连接失败")
                        }
                    }
                }
                callback(json,error)
        }
    }
    */
}


//MARK: Alamofire 3


/*
class CSJSTNetworkManager: NSObject {
    
    static let sharedInstance = CSJSTNetworkManager()
    
    //csj第一步 =。=
    fileprivate struct Constants {
        static let LoginMima     = "LoginMima"
        static let UpdateChannel = "Update Channel"
    }
    
    fileprivate static var PendingOpDict = [String : (Request, Date)]()
    
    /**
     Execute the network request
     
     - parameter key:      unique string in caching dictionary
     - parameter request:  request (or value) in caching dictionary
     - parameter callback: a block executed when network request finished
     */
    fileprivate class func executeRequestWithKey(_ key: String, request: Request, callback: @escaping NetworkCallbackBlock) {
        print("网络请求 = \(key)")
        // Add a new item in the caching dictionary
        PendingOpDict[key] = (request, Date())
        // Executing request
        .responseJSON { (response) in
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
            
//        request.validate(statusCode: 200..<300)
        // Executing request
        
        .responseJSON{(response) in
//        request.responseJSON { (response) in
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
*/

/*
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
        
        func asURLRequest() throws -> URLRequest {
            let url = try Router.baseURLString.asURL()
            
            var urlRequest = URLRequest(url: url.appendPathComponent(path))
            urlRequest.httpMethod = method.rawValue
            
            
            switch self {
            case .updateDeviceToken(_,let device):
                urlRequest =  try ParameterEncoding.encode(urlRequest as URLRequestConvertible, with: device)
            //urlRequest = try  JSONEncoding.default.encode(urlRequest, with: device)
            case .addUser(_, let user):
                urlRequest = try URLEncoding.default.encode(urlRequest, with: user)
            case .updateUser(_,_,let user):
                urlRequest = try URLEncoding.default.encode(urlRequest, with: user)
            case .lockUser(_,_,let user):
                urlRequest = try URLEncoding.default.encode(urlRequest, with: user)
            default:
                break
            }
            return urlRequest
        }
    
        // MARK: URLRequestConvertible
        var URLRequest: NSMutableURLRequest {
//            (inout parameters: [String: AnyObject]) in
            let URL = Foundation.URL(string: Router.baseURLString)!
            let mutableURLRequest = NSMutableURLRequest(url: URL.appendingPathComponent(path))
            mutableURLRequest.httpMethod = method.rawValue
            
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

    
    
    func sendRequest_JSON(_ body:[String : AnyObject], callback : @escaping NetworkCallbackBlock) {
        // Add Headers
        let headers = [
            "Content-Type":"application/json",
            ]
        // JSON Body
        // Fetch Request
        
        Alamofire.request("\(Router.baseURLString)/user/login", withMethod: .post ,parameters: body, encoding: .json, headers: headers)
//        Alamofire.request("\(Router.baseURLString)/user/login", method: HTTPMethod.post, parameters: body, encoding: .json)
//        Alamofire.request("\(Router.baseURLString)/user/login", method: HTTPMethod.post, parameters: body, encoding: .json)
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
*/



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
