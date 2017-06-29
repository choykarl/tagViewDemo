//
//  TagContentView.swift
//  simpleDemo
//
//  Created by karl on 2017-06-27.
//  Copyright © 2017年 Karl. All rights reserved.
//

public protocol TagContentViewDataSource: class {
  func imageAndTagViewMargin() -> CGFloat
  func tagCellHorizontalMargin() -> CGFloat
  func tagCellVerticalMargin() -> CGFloat
}

import UIKit

public class TagContentView: UIView {

  weak var dataSource: TagContentViewDataSource? {
    didSet {
      tagView.dataSource = dataSource
    }
  }
  
  private lazy var tagView: TagView = {
    let imageAndTagViewMargin = self.dataSource?.imageAndTagViewMargin() ?? 0
    let tagView = TagView(frame: CGRect(x: self.iconView.right + imageAndTagViewMargin, y: 0, width: self.width - self.iconView.width - imageAndTagViewMargin, height: 0))
    self.addSubview(tagView)
    return tagView
  }()
  
  private let iconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    iconView.image = UIImage(named: "image")
    addSubview(iconView)
  }
  
  func addCell(_ text: String) {
    tagView.addCell(text)
    setHeight(tagView.bottom)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
