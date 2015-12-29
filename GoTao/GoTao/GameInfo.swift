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
}
