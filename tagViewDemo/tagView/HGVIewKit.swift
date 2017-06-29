//
//  HGVIewKit.swift
//  HungerGame
//
//  Created by wangwenbo on 15/12/19.
//  Copyright © 2015年 Vision Core Crop. All rights reserved.
//

import UIKit

public extension UIView {
  
  var left: CGFloat {
    return self.frame.origin.x
  }
  
  func setLeft(_ x: CGFloat) {
    var frame = self.frame
    frame.origin.x = x
    self.frame = frame
  }
  
  var top: CGFloat {
    return self.frame.origin.y
  }
  
  func setTop(_ y: CGFloat) {
    var frame = self.frame
    frame.origin.y = y
    self.frame = frame
  }
  
  var right: CGFloat {
    return self.frame.origin.x + self.frame.size.width
  }
  
  func setRight(_ right: CGFloat) {
    var frame = self.frame
    frame.origin.x = right - frame.size.width
    self.frame = frame
  }
  
  var bottom: CGFloat {
    return self.frame.origin.y + self.frame.size.height
  }
  
  func setBottom(_ bottom: CGFloat) {
    var frame = self.frame
    frame.origin.y = bottom - frame.size.height
    self.frame = frame
  }
  
  var width: CGFloat {
    return self.frame.size.width
  }
  
  func setWidth(_ width: CGFloat) {
    var frame = self.frame
    frame.size.width = width
    self.frame = frame
  }
  
  var height: CGFloat {
    return self.frame.size.height
  }
  
  func setHeight(_ height: CGFloat) {
    var frame = self.frame
    frame.size.height = height
    self.frame = frame
  }
  
  var centerX: CGFloat {
    return self.center.x
  }
  
  func setCenterX(_ centerX: CGFloat) {
    self.center = CGPoint(x: centerX, y: self.center.y)
  }
  
  var centerY: CGFloat {
    return self.center.y
  }
  
  func setCenterY(_ centerY: CGFloat) {
    self.center = CGPoint(x: self.center.x, y: centerY)
  }
  
  var origin: CGPoint {
    return self.frame.origin
  }
  
  func setOrigin(_ origin: CGPoint) {
    var frame = self.frame
    frame.origin = origin
    self.frame = frame
  }
  
  var size: CGSize {
    return self.frame.size
  }
  
  func setSize(_ size: CGSize) {
    var frame = self.frame
    frame.size = size
    self.frame = frame
  }
  
  /**
   Create a snapshot image of the complete view hierarchy.
   This method should be called in main thread.
   */
  func snapshotImage() -> UIImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0)
    if self.responds(to: #selector(UIView.drawHierarchy(in: afterScreenUpdates:))) {
      self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
    } else {
      self.layer.render(in: UIGraphicsGetCurrentContext()!)
    }
    let snap = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return snap
  }
  
  /**
   Remove all subviews.
   
   @warning Never call this method inside your view's drawRect: method.
   */
  func removeAllSubviews() {
    while self.subviews.count != 0 {
      self.subviews.last?.removeFromSuperview()
    }
  }
  
  /**
   Returns the view's view controller (may be nil).
   */
  func viewController() -> UIViewController? {
    
    var parentResponder: UIResponder? = self
    while parentResponder != nil {
      parentResponder = parentResponder!.next
      if let viewController = parentResponder as? UIViewController {
        return viewController
      }
    }
    
    return nil
  }
  
  func isPointInView(_ point: CGPoint) -> Bool {
    if point.x >= self.left && point.x <= self.right {
      if point.y >= self.top && point.y <= self.bottom {
        return true
      }
    }
    return false
  }
}



