/**
 *
 * Copyright (c) 2015, MarkNote. (MIT Licensed)
 * https://github.com/marknote/GoTao
 */

import Foundation

extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    var asciiValue: UInt32 {
        return asciiValueAt(pos: 0)
    }
    func asciiValueAt(pos: UInt32) -> UInt32 {
        guard count > 0 && Int(pos) < count else  { return 0 }
        return (self[Int(pos)]).unicodeScalarsValue
    }
    
    func findValueWithTags(_ beginTag:String,endTag:String)->String?{
        if let beginLocation = self.range(of: beginTag) {
            let startIndex = beginLocation.upperBound
            let rest = String(self[startIndex...])
            if let endRang = rest.range(of: endTag){
                return String(rest[..<endRang.lowerBound])
            }
        }
        return nil
    }
    
}
extension Character {
    var unicodeScalarsValue: UInt32 {
        return String(self).unicodeScalars.first!.value
    }
}

