//
//  TagView.swift
//  simpleDemo
//
//  Created by karl on 2017-06-27.
//  Copyright © 2017年 Karl. All rights reserved.
//

import UIKit

class TagView: UIView {

  weak var dataSource: TagContentViewDataSource?
  private weak var lastCell: TagCell?
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.purple
  }
  
  func addCell(_ text: String) {
    let cell = TagCell(text)
    addSubview(cell)
    
    if let lastCell = lastCell {
      let horizontalMargin = dataSource?.tagCellHorizontalMargin() ?? 0
      if lastCell.right + cell.width + horizontalMargin > width {
        cell.setTop(lastCell.bottom + (dataSource?.tagCellVerticalMargin() ?? 0))
      } else {
        cell.setTop(lastCell.top)
        cell.setLeft(lastCell.right + horizontalMargin)
      }
    }
    lastCell = cell
    setHeight(cell.bottom)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
