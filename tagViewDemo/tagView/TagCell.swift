//
//  TagCell.swift
//  simpleDemo
//
//  Created by karl on 2017-06-27.
//  Copyright © 2017年 Karl. All rights reserved.
//

import UIKit

public class TagCell: UIView {

  private let label = UILabel()
  init(_ text: String) {
    let font = UIFont.systemFont(ofSize: 12)
    let labelText = " " + text + " "
    let labelWidth = labelText.widthForFont(font)
    
    super.init(frame: CGRect(x: 0, y: 0, width: labelWidth, height: font.lineHeight))
    
    backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255)) / 256, green: CGFloat(arc4random_uniform(255)) / 256, blue: CGFloat(arc4random_uniform(255)) / 256, alpha: 1)
    label.frame = bounds
    label.text = labelText
    label.font = font
    addSubview(label)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
