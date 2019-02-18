//
//  APIServiceClient.swift
//  Transformers
//
//  Created by Deval on 16/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import UIKit
/// This is class created to handle All API calls
class APIServiceClient: NSObject {
    /// Shared object of APIServiceClient
    static let shared = APIServiceClient()
    /// This function is used to handle error
    func handleError(error:NSError?, failure:FailureCompletion, responseCode:Int?) -> Bool {
        if error != nil  {
            if responseCode == 200 {
                return false
            }
            return true
        }
        return false
    }
    
    /**
     Call this function to make an API call to get Authorization token .
     - Parameters:
        - path : URL path
        - success : SuccessCompletion to receive success response
        - failure : FailureCompletion to receive error afrer API call if any
     
     ### Usage Example: ###
     ````
     APIServiceClient.shared.getAllSpark(path: URLPath.AllSpark, success: { (data, response, error)
     ````
     */
    
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
    
    /**
     Call this function to make an API call to get AllTransformer .
     - Parameters:
        - path : URL path
        - success : SuccessCompletion to receive success response
        - failure : FailureCompletion to receive error afrer API call if any
     
     ### Usage Example: ###
     ````
     APIServiceClient.shared.getAllTransformer(path: URLPath.Transformers, success: { (data, response, error)
     ````
     */
    
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
    /**
     Call this function to make an API call to create or update Transformer .
     - Parameters:
        - path : URL path
        - isUpdate : Bool to differentiate between create and update
        - tranformerJson : json dictionary for create and update transformer
        - success : SuccessCompletion to receive success response
        - failure : FailureCompletion to receive error afrer API call if any
     
     ### Usage Example: ###
     ````
     APIServiceClient.shared.createOrUpdateTransformer(path: URLPath.Transformers,isUpdate: isUpdate, tranformerJson: (isUpdate ? configureJsonToUpdateTransformer(_id: tranformer.id!) : configureJsonToCreateTransformer() )
     ````
     */
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
    
    /**
     Call this function to make an API call to delete AllTransformer .
     - Parameters:
        - path : URL path
        - success : SuccessCompletion to receive success response
        - failure : FailureCompletion to receive error afrer API call if any
     
     ### Usage Example: ###
     ````
    APIServiceClient.shared.deleteTransformer(path: (URLPath.Transformers + "/" + "tranformer.id"), success: { (data, response, error)
     ````
     */
    func deleteTransformer(path: String, success: @escaping SuccessCompletion, failure: @escaping FailureCompletion) -> Void {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        APISessionService.shared.callWebServiceWithoutMapping(method: .delete, path: path, params: nil) { (data, response, error) in
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
