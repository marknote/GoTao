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
    
    
    func moveTocurrent(){
        for m in allMoves {
            m.isDead = false
            m.handOfDead = -1
        }
        
        
        playToHand(currentMove)
    }
    
    
    func playToHand(_ hand:Int)-> [MoveGroup]{
        // the very beginning
        if hand == 0 {
            let group0 = MoveGroup()
            group0.name = "B0"
            group0.addMove(allMoves[0])
            return [group0]
        }
       
        //the current step depends on the last status
        var groups = playToHand(hand - 1)
        let lastMove = allMoves[hand]
        let type = String(lastMove.type.rawValue) //"B" or "W"
        let groupsWithSameColor = groups.filter({$0.name.hasPrefix(type)})
        var handled = false
        lastMove.groupName = ""
        for g in groupsWithSameColor {
            for move in g.allMoves {
                if move.isConnectedTo(lastMove) {
                    if lastMove.groupName == "" {
                        handled = true
                        g.addMove(lastMove)
                    } else {
                        // last move is already in a group, current group needs to be merged into that group
                        let groupToConnect = groupsWithSameColor.filter({$0.name == lastMove.groupName}).first!
                        g.mergeTo(groupToConnect)
                    }
                    break
                }
            }// end for move
        }//end for g
        
        if !handled {
            let groupNew = MoveGroup()
            groupNew.name = "\(lastMove.type.rawValue)\(lastMove.handNumber)"
            groupNew.addMove(lastMove)
            groups.append(groupNew)
        }
        // filter out empty groups
        let liveGroups = groups.filter({$0.allMoves.count > 0 })
        let allOccupied = occupiedLocations(allMoves.filter({$0.handNumber <= hand &&  $0.handOfDead == -1}))
        // only need to check opposite party
        let oppositeGroups = liveGroups.filter({!$0.name.hasPrefix(type)})
        for grp in oppositeGroups{
            let liberty = grp.calculateLiberty(allOccupied)
            if liberty == 0 {
                for move in grp.allMoves {
                    move.isDead = true
                    move.handOfDead = hand
                }
                grp.isDead = true
            }
        }

        
        return liveGroups.filter({!$0.isDead })
        
    }
    
    
    
    func currentMoves()->[Move]{
        let moves = allMoves.filter({$0.handNumber <= currentMove && $0.handOfDead == -1})
        return moves
    }
    
    func occupiedLocations(_ moves: [Move])->[Location]{
        var occupied = [Location]()
        //let array = currentMoves()
        for m in moves{
            if m.isDead {
                continue
            }
            if !occupied.contains(m.location){
                occupied.append(m.location)
            }
        }
        return occupied
    }

    
    
    

}
