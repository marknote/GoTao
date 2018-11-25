/**
 *
 * Copyright (c) 2015, MarkNote. (MIT Licensed)
 * https://github.com/marknote/GoTao
 */

import Foundation

open class SGFParser {
    
    func parse(_ kifu:String)->GameInfo{
        let game = GameInfo()
        let nodes = kifu.split(separator: ";")
            .map(String.init)
        
        if nodes.count >= 2 {
            let metaNode = nodes[1]
            if let pb = metaNode.findValueWithTags("PB[", endTag: "]"){
                game.playerBlack = pb
            }
            if let pw = metaNode.findValueWithTags("PW[", endTag: "]"){
                game.playerWhite = pw
            }
            
            if let br = metaNode.findValueWithTags("BR[", endTag: "]"){
                game.rankBlack = br
            }
            if let wr = metaNode.findValueWithTags("WR[", endTag: "]"){
                game.rankWhite = wr
            }
            if let re = metaNode.findValueWithTags("RE[", endTag: "]"){
                game.result = re
            }
            if let dt = metaNode.findValueWithTags("DT[", endTag: "]"){
                game.date = dt
            }
        }
        
        let moveSteps = nodes
            .filter{($0.hasPrefix("B[")||$0.hasPrefix("W["))&&$0.count >= 4 && $0[4] == "]"}
        game.allMoves = [Move]()
        if moveSteps.count > 0 {
            for i in 0...moveSteps.count - 1 {
                let move = Move(step: moveSteps[i], hand: i)
                game.allMoves.append(move)
            }
        }
        return game
    }
}
