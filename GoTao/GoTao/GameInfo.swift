/**
 *
 * Copyright (c) 2015, MarkNote. (MIT Licensed)
 * https://github.com/marknote/MarknoteParser
 */

import Foundation

class GameInfo: NSObject {
    
    var title: String = ""
    var metaInfo: String = ""
    
    var playerWhite: String = ""
    var playerBlack: String = ""
    var rankWhite: String = ""
    var rankBlack: String = ""
    var result: String = ""
    var date:String = ""
    
    var allMoves: [Move] = [Move]()
    var currentMove: Int = 0
    func goBack(){
        currentMove -= 1
        if (currentMove < 0){
            currentMove = 0
        }
    }
    func goForward(){
        currentMove += 1
        if (currentMove > allMoves.count - 1){
            currentMove = allMoves.count - 1
        }
    }
    func currentMoves()->[Move]{
        let moves = allMoves[0..<currentMove + 1]
        return Array(moves)

    }
    
    func assignGroups() ->[MoveGroup]{
        let array = currentMoves().sort({ $0.location.distance() < $1.location.distance() })
        let count = array.count
        var groups = [MoveGroup]()
        var groupIndex = 0
        
        for  move in array
        {
            move.groupName = ""
        }
        
        for var i = 0;i < count; i++
        {   
            let move = array[i]
            if  move.groupName.characters.count > 0
            {continue}
            
            for previous in array[0..<i]
            {
                if previous.groupName.characters.count > 0
                    && move.isConnectedTo(previous){
                        move.groupName = previous.groupName;
                }
            }
            
            if  move.groupName.characters.count > 0
            {
                continue
            }
            groupIndex += 1
            let group = MoveGroup()
            group.type = move.type
            group.sequence = groupIndex
            group.name = "\(group.type.rawValue)\(group.sequence)"
            groups.append(group)
            group.addMove(move)
            
        }
        return groups;
    }

}
