//
//  APISessionService.swift
//  Transformers
//
//  Created by Deval on 16/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import UIKit

typealias SuccessCompletion = (Data?, HTTPURLResponse?, Error?) -> Void
typealias FailureCompletion = (_ error: String) -> (Void)

public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}
/// This is a class created to manage URLSession
class APISessionService: NSObject {
    static let shared = APISessionService()
    
    var headers = [String: String]()
    let configuration = URLSessionConfiguration.default
    var session = URLSession()
    
    private override init() {
        super.init()
        
        configuration.timeoutIntervalForRequest = 120
        configuration.timeoutIntervalForResource = 120
        session = URLSession(configuration: configuration)
        
        setBasicRequestHeaders()
    }
    
    func setBasicRequestHeaders()  {
        headers["Content-Type"] = "application/json"
    }
    
    func setAdditionalRequestHeaders(key: String, value: String) {
        headers[key] = value
    }
    
    //MARK: Without Mappable Webcall
    func callWebServiceWithoutMapping(method: HTTPMethod, path: String ,params:[String:AnyObject]?, completion:@escaping SuccessCompletion) -> Void {
        
        var urlRequest = URLRequest(url: URL(string: path)!)
        urlRequest.httpMethod = method.rawValue
        for item in headers {
            urlRequest.addValue(item.value, forHTTPHeaderField: item.key)
        }
        if params != nil {
            let jsonData = try? JSONSerialization.data(withJSONObject: params as Any)
            urlRequest.httpBody = jsonData
        }
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            if (error != nil) {
                completion(data, nil, error)
            } else {
                completion(data, (response as! HTTPURLResponse), error)
            }
        }
        task.resume()
    }
}
