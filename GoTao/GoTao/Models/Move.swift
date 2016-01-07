/**
 *
 * Copyright (c) 2015, MarkNote. (MIT Licensed)
 * https://github.com/marknote/MarknoteParser
 */

import Foundation

class Move: NSObject {
    
    var location: Location
    var type:StoneType
    var isDead:Bool = false
    var groupName = ""
    
    
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
    
    func isConnectedTo(another:Move)->Bool{
        return  (self.type == another.type) && self.location.isConnectedTo(another.location)
        
    }
    
    
    
    func calculateLiberty(occupied:[Location])->Int{
        var liberty = 4
        if (location.x == 0 || location.x == 19 || location.y == 0 || location.y == 19){
            liberty = 3
            if (location.x == 0 && location.y == 0
                || location.x == 19 && location.y == 0
                || location.x == 0 && location.y == 19
                || location.x == 19 && location.y == 19
                ){
                    liberty = 2
            }            
        }
        for l in occupied {
            if self.location.isEqual(l) {
               continue 
            }
            if self.location.isConnectedTo(l) {
                liberty -= 1
            }
        }
        return liberty
    }
    
    override var description:String {
        return "\(type) x:\(location.x) y:\(location.y)"
    }


}
