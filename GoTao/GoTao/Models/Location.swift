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
}
