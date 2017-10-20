/**
 *
 * Copyright (c) 2015, MarkNote. (MIT Licensed)
 * https://github.com/marknote/MarknoteParser
 */

import Foundation

extension String {
    var asciiValue: UInt32 {
        guard let first = characters.first, characters.count == 1 else  { return 0 }
        return first.unicodeScalarsValue
    }
    func asciiValueAt(pos: UInt32) -> UInt32 {
        guard characters.count > 0 && Int(pos) < characters.count else  { return 0 }
        return Array(characters)[Int(pos)].unicodeScalarsValue
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

