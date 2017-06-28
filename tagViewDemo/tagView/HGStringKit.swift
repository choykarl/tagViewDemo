//
//  HGStringKit.swift
//  HungerGame
//
//  Created by wangwenbo on 15/12/18.
//  Copyright © 2015年 Vision Core Crop. All rights reserved.
//

import UIKit

extension String {
  
  /**
   e.g. "12345"[0] as Character
   
   - parameter i: index
   
   - returns: Character
   */
  subscript (i: Int) -> Character {
    return self[self.characters.index(self.startIndex, offsetBy: i)]
  }
  
  /**
   e.g. "12345"[0] as String
   
   - parameter i: index
   
   - returns: String
   */
  subscript (i: Int) -> String {
    return String(self[i] as Character)
  }
  
  subscript (r: Range<Int>) -> String {
    return self.substring(with: characters.index(startIndex, offsetBy: r.lowerBound)..<characters.index(startIndex, offsetBy: r.upperBound))
  }
  
  // MARK: - Utilities
  /// return String length
  var length: Int {
    return characters.count
  }
  
  /**
   Create a string with the file in main bundle (similar to [UIImage imageNamed:]).
   
   @param name The file name (in main bundle).
   
   @return A new string create from the file in UTF-8.
   */
  func stringNamed(_ name: String) -> String? {
    let path = Bundle.main.path(forResource: name, ofType: "")
    do {
      let content = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
      return content
    } catch _ as NSError {
      return nil
    }
  }
  
  /**
   Trim blank characters (space and newline) in head and tail.
   @return the trimmed string.
   */
  func stringByTrim() -> String {
    let set = CharacterSet.whitespacesAndNewlines
    return self.trimmingCharacters(in: set)
  }
  
  // MARK: - Drawing
  /**
  Returns the size of the string if it were rendered with the specified constraints.
  
  @param font The font to use for computing the string size.
  
  @param size The maximum acceptable size for the string. This value is
  used to calculate where line breaks and wrapping would occur.
  
  @return The width and height of the resulting string's bounding box.
  These values may be rounded up to the nearest whole number.
  */
  func sizeForFont(_ font: UIFont, size: CGSize) -> CGSize {
    let fString = self as NSString
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
    let attrDict = [
      NSFontAttributeName: font,
      NSParagraphStyleAttributeName: paragraphStyle
    ]
    let rect = fString.boundingRect(with: size,
      options: [.truncatesLastVisibleLine, .usesLineFragmentOrigin],
      attributes: attrDict,
      context: nil)
    return rect.size
  }
  
  /**
   Returns the width of the string if it were to be rendered with the specified
   font on a single line.
   
   @param font The font to use for computing the string width.
   
   @return The width of the resulting string's bounding box. These values may be
   rounded up to the nearest whole number.
   */
  func widthForFont(_ font: UIFont) -> CGFloat {
    let size = self.sizeForFont(font, size: CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT)))
    return size.width
  }
  
  /**
   Returns the height of the string if it were rendered with the specified constraints.
   
   @param font The font to use for computing the string size.
   
   @param width The maximum acceptable width for the string. This value is used
   to calculate where line breaks and wrapping would occur.
   
   @return The height of the resulting string's bounding box. These values
   may be rounded up to the nearest whole number.
   */
  func heightForFont(_ font: UIFont, width: CGFloat) -> CGFloat {
    let size = self.sizeForFont(font, size: CGSize(width: width, height: CGFloat(MAXFLOAT)))
    return size.height
  }
  
  func getRoomID() -> Int {
    let roomInfo = self.components(separatedBy: "?roomOwnerId=").first
    return Int((roomInfo?.components(separatedBy: "blinnnk://roominfo/").last)!)!
  }
  
  func getRoomOwnerId() -> Int {
    return Int(self.components(separatedBy: "?roomOwnerId=").last!)!
  }
  
  /**
   Returns all of the substring range array
   @param findStr the substring 
   @return array
   */
  func rangesOfString(_ findStr: String) -> [Range<String.Index>] {
    var arr = [Range<String.Index>]()
    var startInd = self.startIndex
    // check first that the first character of search string exists
    if self.characters.contains(findStr.characters.first!) {
      // if so set this as the place to start searching
      startInd = self.characters.index(of: findStr.characters.first!)!
    } else {
      // if not return empty array
      return arr
    }
    var i = self.characters.distance(from: self.startIndex, to: startInd)
    while i<=self.characters.count - findStr.characters.count {
      if self[self.characters.index(self.startIndex, offsetBy: i)..<self.characters.index(self.startIndex, offsetBy: i + findStr.characters.count)] == findStr {
        arr.append(self.characters.index(self.startIndex, offsetBy: i)..<self.characters.index(self.startIndex, offsetBy: i + findStr.characters.count))
        i = i + findStr.characters.count
      } else {
        i = i + 1
      }
    }
    
    return arr
  }
  
  func deleteUselessWrap() -> String {
    var str = self
    while true {
      if str.hasSuffix("\n") {
        str = str.substring(to: str.characters.index(str.endIndex, offsetBy: -1))
      } else {
        break
      }
    }
    return str
  }
  
  func indexOfCharacter(_ char: Character) -> Int? {
    if let idx = self.characters.index(of: char) {
      return self.characters.distance(from: self.startIndex, to: idx)
    }
    return nil
  }
  
  func isAllSpaceString() -> Bool {
    let string: NSString = self as NSString
    if string.length <= 0 {
      return true
    }
    
    var isAllSpaceString = true
    for i in 0..<characters.count {
      let range = NSRange(location: i, length: 1)
      if string.substring(with: range).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).characters.count <= 0 {
        isAllSpaceString = true
      } else {
        isAllSpaceString = false
        break
      }
    }
    
    return isAllSpaceString
  }
  
  func truncatedRange(_ size: CGSize, font: UIFont) -> NSRange {
    let attributeString = NSAttributedString(string: self, attributes: [NSFontAttributeName: font])
    let textStorate = NSTextStorage(attributedString: attributeString)
    let layoutManager = NSLayoutManager()
    textStorate.addLayoutManager(layoutManager)
    let textContainer = NSTextContainer(size: size)
    textContainer.lineBreakMode = .byTruncatingTail
    layoutManager.addTextContainer(textContainer)
    let truncatedrange = layoutManager.truncatedGlyphRange(inLineFragmentForGlyphAt: 0)
    return truncatedrange
  }
  
  static func sqliteEscape(_ keyWord: String) -> String {
    var result = keyWord.replacingOccurrences(of: "''", with: "'")
    result = result.replacingOccurrences(of: "/[", with: "[")
    result = result.replacingOccurrences(of: "/]", with: "]")
    result = result.replacingOccurrences(of: "/%", with: "%")
    result = result.replacingOccurrences(of: "/&", with: "&")
    result = result.replacingOccurrences(of: "/_", with: "_")
    result = result.replacingOccurrences(of: "/(", with: "(")
    result = result.replacingOccurrences(of: "/)", with: ")")
    return result
  }
  
  static func getImagePath(_ imageName: String, imageType: String = "png") -> String {
    return ((Bundle.main.resourcePath ?? "") as NSString).appendingPathComponent(("\(imageName).\(imageType)"))
  }
  
  var intValue: Int {
    return int ?? 0
  }
  
  var int: Int? {
    return Int(self)
  }
}


