//
//  EZTLabel.swift
//  Ezeetransport
//
//  Created by Harsh Soni on 01/06/20.
//  Copyright © 2020 Harsh Soni. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var PDCorner: CGFloat {
        get {
            return self.layer.cornerRadius
        } set {
            self.layer.cornerRadius = newValue <= 0 ? self.bounds.width/2 : newValue
            self.clipsToBounds = true
        }
    }
    @IBInspectable var PDBorder: Bool {
        get {
            return self.PDBorder
        } set {
            self.layer.borderWidth = 1
            self.layer.borderColor = #colorLiteral(red: 0.423999995, green: 0.423999995, blue: 0.6079999804, alpha: 1)
        }
    }
}
extension UILabel {
    @IBInspectable var PDFont: Bool {
        get {
            return self.PDFont
        } set {
            self.func_DynamicFontSize()
        }
    }
    private func func_DynamicFontSize() {
        switch UIScreen.main.bounds.size.height {
        case 320.0:
            self.font = self.font.withSize(self.font.pointSize * 0.7)
            break
        case 667.0:
            self.font = self.font.withSize(self.font.pointSize * 0.8)
            break
        case 736.0:
            self.font = self.font.withSize(self.font.pointSize * 0.9)
            break
        case 896.0, 812.0:
            self.font = self.font.withSize(self.font.pointSize)
            break
        default:
            self.font = self.font.withSize(self.font.pointSize)
            break
        }
    }
}
extension UIButton {
    @IBInspectable var PDFont: Bool {
        get {
            return self.PDFont
        } set {
            self.func_DynamicFontSize()
        }
    }
    private func func_DynamicFontSize() {
        guard let isTitleLabel = self.titleLabel else { return }
        switch UIScreen.main.bounds.size.height {
        case 320.0:
            isTitleLabel.font = isTitleLabel.font.withSize(isTitleLabel.font.pointSize * 0.7)
            break
        case 667.0:
            isTitleLabel.font = isTitleLabel.font.withSize(isTitleLabel.font.pointSize * 0.8)
            break
        case 736.0:
            isTitleLabel.font = isTitleLabel.font.withSize(isTitleLabel.font.pointSize * 0.9)
            break
        case 896.0, 812.0:
            isTitleLabel.font = isTitleLabel.font.withSize(isTitleLabel.font.pointSize)
            break
        default:
            isTitleLabel.font = isTitleLabel.font.withSize(isTitleLabel.font.pointSize)
            break
        }
    }
}
extension UITextField {
    @IBInspectable var PDFont: Bool {
        get {
            return self.PDFont
        } set {
            self.func_DynamicFontSize()
        }
    }
    private func func_DynamicFontSize() {
        guard let isFont = self.font else { return }
        switch UIScreen.main.bounds.size.height {
        case 320.0:
            self.font = isFont.withSize(isFont.pointSize * 0.7)
            break
        case 667.0:
            self.font = isFont.withSize(isFont.pointSize * 0.8)
            break
        case 736.0:
            self.font = isFont.withSize(isFont.pointSize * 0.9)
            break
        case 896.0, 812.0:
            self.font = isFont.withSize(isFont.pointSize)
            break
        default:
            self.font = isFont.withSize(isFont.pointSize)
            break
        }
    }
}


extension Int {
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(self)"
        }
    }
}

extension Date {

    func timeAgoSinceDate() -> String {

        // From Time
        let fromDate = self

        // To Time
        let toDate = Date()

        // Estimation
        // Year
        if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {

            return interval == 1 ? "\(interval)" + " " + "year" : "\(interval)" + " " + "years"
        }

        // Month
        if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {

            return interval == 1 ? "\(interval)" + " " + "month" : "\(interval)" + " " + "months"
        }

        // Day
        if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {

            return interval == 1 ? "\(interval)" + " " + "day" : "\(interval)" + " " + "days"
        }

        // Hours
        if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {

            return interval == 1 ? "\(interval)" + " " + "hour" : "\(interval)" + " " + "hours"
        }

        // Minute
        if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {

            return interval == 1 ? "\(interval)" + " " + "minute" : "\(interval)" + " " + "minutes"
        }

        return "a moment ago"
    }
}
