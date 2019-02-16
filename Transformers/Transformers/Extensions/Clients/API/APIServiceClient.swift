//
//  APIServiceClient.swift
//  Transformers
//
//  Created by Deval on 16/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import UIKit

class APIServiceClient: NSObject {
    static let shared = APIServiceClient()
    
    func handleError(error:NSError?, failure:FailureCompletion, responseCode:Int?) -> Bool {
        if error != nil  {
            if responseCode == 200 {
                return false
            }
            return true
        }
        return false
    }
    
    func getAllSpark(path: String, success: @escaping SuccessCompletion, failure: @escaping FailureCompletion) -> Void {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        APISessionService.shared.callWebServiceWithoutMapping(method: .get, path: path, params: nil) { (data, response, error) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                if !self.handleError(error: error as NSError?, failure: failure, responseCode: response?.statusCode) {
                    success(data, response, error)
                } else {
                    failure(error?.localizedDescription ?? "error")
                }
            }
        }
    }
    
    func getAllTransformer(path: String, success: @escaping SuccessCompletion, failure: @escaping FailureCompletion) -> Void {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        APISessionService.shared.callWebServiceWithoutMapping(method: .get, path: path, params: nil) { (data, response, error) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                if !self.handleError(error: error as NSError?, failure: failure, responseCode: response?.statusCode) {
                    success(data, response, error)
                } else {
                    failure(error?.localizedDescription ?? "error")
                }
            }
        }
    }
    
    
    func createTransformer(path: String, tranformerJson: Dictionary<String, Any>, success: @escaping SuccessCompletion, failure: @escaping FailureCompletion) -> Void {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        APISessionService.shared.callWebServiceWithoutMapping(method: .post, path: path, params: tranformerJson as [String : AnyObject]) { (data, response, error) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                if !self.handleError(error: error as NSError?, failure: failure, responseCode: response?.statusCode) {
                    success(data, response, error)
                } else {
                    failure(error?.localizedDescription ?? "error")
                }
            }
        }
    }
    
    func createOrUpdateTransformer(path: String,isUpdate : Bool, tranformerJson: Dictionary<String, Any>, success: @escaping SuccessCompletion, failure: @escaping FailureCompletion) -> Void {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        APISessionService.shared.callWebServiceWithoutMapping(method: (isUpdate ? .put : .post), path: path, params: tranformerJson as [String : AnyObject]) { (data, response, error) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                if !self.handleError(error: error as NSError?, failure: failure, responseCode: response?.statusCode) {
                    success(data, response, error)
                } else {
                    failure(error?.localizedDescription ?? "error")
                }
            }
        }
    }
    
}
