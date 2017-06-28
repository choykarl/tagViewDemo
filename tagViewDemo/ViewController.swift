//
//  ViewController.swift
//  tagViewDemo
//
//  Created by karl on 2017-06-28.
//  Copyright © 2017年 Karl. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TagContentViewDataSource {
  
  let array = ["123123", "123", "22", "12312", "pppp", "1", "1010"]
  var tagView: TagContentView?
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tagView = TagContentView(frame: CGRect(x: 10, y: 50, width: view.width - 20, height: 30))
    tagView?.dataSource = self
    view.addSubview(tagView!)
    
  }
  
  func tagCellVerticalMargin() -> CGFloat {
    return 8
  }
  
  func tagCellHorizontalMargin() -> CGFloat {
    return 10
  }
  
  func imageAndTagViewMargin() -> CGFloat {
    return 8
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    let index = Int(arc4random_uniform(7))
    tagView?.addCell(array[index])
  }
}

