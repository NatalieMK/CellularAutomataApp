//
//  Extensions.swift
//  CellularAutomata
//
//  Created by Natalie on 1/12/22.
//

import Foundation
import UIKit

extension Bool {
    var intValue: Int {
        return self ? 1 : 0
    }
}

extension Int {
    var middleValue: Int {
        var mid = floor(Double(self/2))
        return Int(mid)
    }
}

extension UIView {
    
    // View constants for convienence
    public var width: CGFloat {
        return self.frame.size.width
    }
    public var height: CGFloat {
        return self.frame.size.height
    }
    public var top: CGFloat{
        return self.frame.origin.y
    }
    public var bottom: CGFloat{
        return self.frame.size.height + self.frame.origin.y
    }
    public var left: CGFloat{
        return self.frame.origin.x
    }
    public var right: CGFloat{
        return self.frame.size.width + self.frame.origin.x
    }
    
    // Custom extension to make AutoLayout more manageable
    public func autoLayoutBasedOnView(view: UIView, topOffset: CGFloat?, bottomOffset: CGFloat?, leadingOffset: CGFloat?, trailingOffset: CGFloat?){
        var constraints = [NSLayoutConstraint]()
        if topOffset != nil{
            constraints.append(view.topAnchor.constraint(equalTo: self.topAnchor, constant: topOffset ?? 0))
        }
        if leadingOffset != nil {
        constraints.append(view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leadingOffset ?? 0))
        }
        if trailingOffset != nil {
        constraints.append(view.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -(trailingOffset?.magnitude ?? 0)))
        }
        if bottomOffset != nil {
        constraints.append(view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -(bottomOffset?.magnitude ?? 0)))
        }
        NSLayoutConstraint.activate(constraints)
    }
    
    public func autoLayoutBasedOnAnchors(view: UIView, newTopAnchor: NSLayoutYAxisAnchor?, newBottomAnchor: NSLayoutYAxisAnchor?, newLeftAnchor: NSLayoutXAxisAnchor?, newRightAnchor: NSLayoutXAxisAnchor?, padding: CGFloat?){
        var constraints = [NSLayoutConstraint]()
        if newTopAnchor != nil {
            constraints.append(view.topAnchor.constraint(equalTo: newTopAnchor!, constant: padding ?? 0))
        }
        if newLeftAnchor != nil {
            constraints.append(view.leftAnchor.constraint(equalTo: newLeftAnchor!, constant: padding ?? 0))
        }
        if newBottomAnchor != nil {
            constraints.append(view.bottomAnchor.constraint(equalTo: newBottomAnchor!, constant: -(padding ?? 0)))
        }
        if newRightAnchor != nil {
            constraints.append(view.rightAnchor.constraint(equalTo: newRightAnchor!, constant: -(padding ?? 0)))
        }
        NSLayoutConstraint.activate(constraints)
    }
}
    
extension Array {

    var middle: Element? {
        guard count != 0 else { return nil }
        let middleIndex = (count > 1 ? count - 1 : count) / 2
        return self[middleIndex]
    }
}
