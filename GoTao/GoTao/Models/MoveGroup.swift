/**
 *
 * Copyright (c) 2015, MarkNote. (MIT Licensed)
 * https://github.com/marknote/GoTao
 */

import Foundation

class MoveGroup:NSObject{
    
    var type:StoneType = .black
    var sequence:Int = 0
    var name = ""
    var allMoves: [Move] = [Move]()
    var isDead = false 
    
    
    func addMove(_ m:Move){
       
        m.groupName = name
        allMoves.append(m)
       
    }
    
    func calculateLiberty(_ occupied:[Location])->Int{
        return allMoves.reduce(0, {$0 + $1.calculateLiberty(occupied)} )
    }
    
    func mergeTo(_ groupToMerge:MoveGroup) {
        for move in allMoves {
            
            groupToMerge.addMove(move)
        }
        allMoves.removeAll()
    }
    override var description: String {
        return name
    }
}
