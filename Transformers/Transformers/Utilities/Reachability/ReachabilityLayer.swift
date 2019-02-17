//
//  ReachabilityLayer.swift
//  BPI
//

import Foundation
import UIKit

class ReachabilityLayer: NSObject {
    
    static let shared = ReachabilityLayer()
    let reachability = Reachability()!
    var isAlertPresented = false
    
    private override init() {}
    
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
