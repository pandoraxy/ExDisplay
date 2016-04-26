//
//  EXNetworking.swift
//  ExDisplay
//
//  Created by lihao on 16/4/22.
//  Copyright © 2016年 AppStudio. All rights reserved.
//

import UIKit

class EXNetworking: NSObject {
    // 带参
    static func request(method: String, url: String, params: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>(), callback: (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void) {
        let manager = NetworkManager(url: url, method: method, params: params, callback: callback)
        manager.fire()
    }
    
    // 不带参
    static func request(method: String, url: String, callback: (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void) {
        let manager = NetworkManager(url: url, method: method, callback: callback)
        manager.fire()
    }
    
    // 两个get接口（带与不带参）
    static func get(url: String, callback: (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void) {
        let manager = NetworkManager(url: url, method: "GET", callback: callback)
        manager.fire()
    }
    static func get(url: String, params: Dictionary<String, AnyObject>, callback: (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void) {
        let manager = NetworkManager(url: url, method: "GET", params: params, callback: callback)
        manager.fire()
    }
    
    // 两个 post 接口（带与不带 params）
    static func post(url: String, callback: (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void) {
        let manager = NetworkManager(url: url, method: "POST", callback: callback)
        manager.fire()
    }
    static func post(url: String, params: Dictionary<String, AnyObject>, callback: (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void) {
        let manager = NetworkManager(url: url, method: "POST", params: params, callback: callback)
        manager.fire()
    }
    
    func buildParams(parameters: [String: AnyObject]) -> String {
        var components: [(String, String)] = []
        for key in Array(parameters.keys).sort(<) {
            let value: AnyObject! = parameters[key]
            components += self.queryComponents(key, value)
        }
        
        return (components.map{"\($0)=\($1)"} as [String]).joinWithSeparator("&")
    }
    
    func queryComponents(key: String, _ value: AnyObject) -> [(String, String)] {
        var components: [(String, String)] = []
        if let dictionary = value as? [String: AnyObject] {
            for (nestedKey, value) in dictionary {
                components += queryComponents("\(key)[\(nestedKey)]", value)
            }
        } else if let array = value as? [AnyObject] {
            for value in array {
                components += queryComponents("\(key)", value)
            }
        } else {
            components.appendContentsOf([(escape(key), escape("\(value)"))])
        }
        
        return components
    }
    func escape(string: String) -> String {
        let legalURLCharactersToBeEscaped: CFStringRef = ":&=;+!@#$()',*"
        return CFURLCreateStringByAddingPercentEscapes(nil, string, nil, legalURLCharactersToBeEscaped, CFStringBuiltInEncodings.UTF8.rawValue) as String
    }
}

extension String {
    var nsdata: NSData {
        return self.dataUsingEncoding(NSUTF8StringEncoding)!
    }
}

struct File {
    let name: String!
    let url: NSURL!
    init(name: String, url: NSURL) {
        self.name = name
        self.url = url
    }
}

class NetworkManager {
    let method: String!
    let params: Dictionary<String,AnyObject>
    let callback:(data: NSData!, reponse:NSURLResponse!, error: NSError!) -> Void
    
    let session = NSURLSession.sharedSession()
    let url:String!
    var request: NSMutableURLRequest!
    var task: NSURLSessionTask!
    
    init(url: String, method: String, params: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>(), callback: (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void) {
        self.url = url
        self.request = NSMutableURLRequest(URL: NSURL(string: url)!)
        self.method = method
        self.params = params
        self.callback = callback
    }
    
    func buildRequest() {
        if self.method == "GET" && self.params.count > 0 {
            self.request = NSMutableURLRequest(URL: NSURL(string: url + "?" + buildParams(self.params))!)
        }
        request.HTTPMethod = self.method
        if self.params.count > 0 {
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }
    }
    
    func buildBody() {
        if self.params.count > 0 && self.method != "GET" {
            request.HTTPBody = buildParams(self.params).nsdata
        }
    }
    
    func fireTask() {
        task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            self.callback(data: data, reponse: response, error: error)
        })
        task.resume()
    }
    
    func fire() {
        buildRequest()
        buildBody()
        fireTask()
    }
    
    // 从 Alamofire 偷了三个函数
    func buildParams(parameters: [String: AnyObject]) -> String {
        var components: [(String, String)] = []
        for key in Array(parameters.keys).sort(<) {
            let value: AnyObject! = parameters[key]
            components += self.queryComponents(key, value)
        }
        
        return (components.map{"\($0)=\($1)"} as [String]).joinWithSeparator("&")
    }
    
    func queryComponents(key: String, _ value: AnyObject) -> [(String, String)] {
        var components: [(String, String)] = []
        if let dictionary = value as? [String: AnyObject] {
            for (nestedKey, value) in dictionary {
                components += queryComponents("\(key)[\(nestedKey)]", value)
            }
        } else if let array = value as? [AnyObject] {
            for value in array {
                components += queryComponents("\(key)", value)
            }
        } else {
            components.appendContentsOf([(escape(key), escape("\(value)"))])
        }
        
        return components
    }
    
    func escape(string: String) -> String {
        let legalURLCharactersToBeEscaped: CFStringRef = ":&=;+!@#$()',*"
        return CFURLCreateStringByAddingPercentEscapes(nil, string, nil, legalURLCharactersToBeEscaped, CFStringBuiltInEncodings.UTF8.rawValue) as String
    }
}
