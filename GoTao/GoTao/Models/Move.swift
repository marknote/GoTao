/**
 *
 * Copyright (c) 2015, MarkNote. (MIT Licensed)
 * https://github.com/marknote/MarknoteParser
 */

import Foundation

class Move: NSObject {
    
    var location: Location
    var type:StoneType
    
    init(type:StoneType,loc:Location) {
        self.location = loc
        self.type = type
    }
    init(step:String){
        let color =  StoneType(rawValue:step[step.startIndex])
        let x = step.asciiValueAt(pos: 2) - "a".asciiValue
        let y = step.asciiValueAt(pos: 3) - "a".asciiValue
        
        self.type = color!
        self.location = Location(x: x,y: y)        
    }

}
