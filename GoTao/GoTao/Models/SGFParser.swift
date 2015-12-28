/**
 *
 * Copyright (c) 2015, MarkNote. (MIT Licensed)
 * https://github.com/marknote/MarknoteParser
 */

import Foundation

public class SGFParser {
    
    func parse(kifu:String)->GameInfo{
        let game = GameInfo()
        let moves = kifu.characters.split { $0 == ";" }
            .map(String.init)
            .filter{($0.hasPrefix("B[")||$0.hasPrefix("W["))&&$0.characters.count==5}
            .map{Move(step: $0 as String)}
        print(moves)
        game.allMoves = moves
        return game
    }
    
}