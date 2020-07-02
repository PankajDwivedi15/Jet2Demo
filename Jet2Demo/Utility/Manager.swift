//
//  Manager.swift
//  Bonauf
//
//  Created by cis on 4/4/18.
//  Copyright © 2018 cis. All rights reserved.
//

import UIKit
import SystemConfiguration
import AVFoundation
import Foundation

let ManagerSharedInstance = Manager()

class Manager: NSObject {
    
  
    class var sharedInstance: Manager {
        return ManagerSharedInstance
    }
    
    
    func emailAddressValidation(_ emailAddress:String) -> Bool {

        let emailRegex = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
            "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
        return emailTest.evaluate(with: emailAddress)
    }
    
    func passwordValidation(_ password:String) -> Bool {
        
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&][A-Za-z\\d$@$#!%**?&]{8,}")
        return passwordPredicate.evaluate(with: password)
    }
    
    func showAlert(_ vc:UIViewController, message: String = AlertMsg.Some_IssueWithServer.rawValue) {
        let alert = UIAlertController(title: AlertMsg.Alert_Title.rawValue, message:message , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
 
    func getTrimmedString (_ str:String?) -> String? {
       return str?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    
    
    func isNetworkConnected(_ vc:UIViewController) -> Bool {
        if self.isNetworkConnected() {
            return true
        }
        else {
            self.showAlert(vc, message: AlertMsg.Some_IssueInternet.rawValue)
            return false
        }
    }
    
    private func isNetworkConnected() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
}



enum AlertMsg: String {
    case Alert_Title = "Jet2Demo Alert"
    case Some_IssueInternet = "No internet connection available, please check your internet connection"
    case Some_IssueWithServer = "Some issue with server"
    case Check_Email_Cannot_Empty = "Please fill up the email field."
    case Check_FirstName = "First name cannot be empty"
    case Check_LastName = "Last name cannot be empty"
    case Check_Email_Wrong = "Email is not in correct formate"
    case Check_Password = "Password field cannot be empty"
    case Check_Password_Type = "Password should be more then 6 digit."
    
    case Alert_LogoutMessage = "Do you want to logout ?"
}
