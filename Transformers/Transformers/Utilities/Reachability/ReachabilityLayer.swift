//
//  ReachabilityLayer.swift
//  BPI
//

import Foundation
import UIKit

/// This is a class created for handling Network reachability in Project
class ReachabilityLayer: NSObject {
    /// Shared instance of ReachabilityLayer
    static let shared = ReachabilityLayer()
    /// Instance of Reachability
    let reachability = Reachability()!
    /// ReachabilityLayer object initializer
    private override init() {}
/** Call this function to check network reachability */
    func checkForReachability() {
        reachability.whenReachable = { reachability in
            print("app reachable to network")
        }
        reachability.whenUnreachable = { _ in
            print("Not reachable")
            self.displayNetworkErrorAlert()
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start Reachability notifier")
        }
    }
    /**
     ### Usage Example: ###
     ````
     ReachabilityLayer.shared.checkForReachability()
     ````
     */
    /**
    Call this function to check network reachability related error
    */
    func displayNetworkErrorAlert()  {
        let closeAction = UIAlertAction(title: kAlertButtonTitle, style: .cancel){ action -> Void in
            exit(0)
        }
        let retryAction: UIAlertAction = UIAlertAction(title: "Retry", style: .default) { action -> Void in
            if self.reachability.connection == .none {
                self.checkForReachability()
                self.displayNetworkErrorAlert()
            }
        }
        Alert.displayAlert(message: "Unable to establish connection. Check your internet connection and try again.", withTitle: kAlertTitle, withActions: [closeAction,retryAction])
    }
}
