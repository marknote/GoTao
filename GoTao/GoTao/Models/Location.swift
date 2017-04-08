/**
 *
 * Copyright (c) 2015, MarkNote. (MIT Licensed)
 * https://github.com/marknote/MarknoteParser
 */

import Foundation

class Location: NSObject {
    var x:UInt32
    var y:UInt32
    init(x:UInt32,y:UInt32) {
        self.x = x
        self.y = y
    }
    
    func distance() ->UInt32{
        return self.x * self.x  + self.y * self.y
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let obj = object as? Location {
            return x == obj.x && y == obj.y
        } else {
            return false
        }
    }
    
    func isConnectedTo(_ another:Location)->Bool{        
        let deltaX = abs(Int(x) - Int(another.x))
        if deltaX > 1 {
            return false
        }
        let deltaY = abs(Int(self.y) - Int(another.y))
        return deltaX + deltaY == 1
    }
    
    override var description:String {
        return "x:\(x) y:\(y)"
    }
    
}
