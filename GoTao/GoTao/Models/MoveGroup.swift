//
//  MoveGroup.swift
//  GoTao
//
//  Created by bill on 1/1/16.
//  Copyright © 2016 markNote. All rights reserved.
//

import Foundation

class MoveGroup{
    var moves = [Move]()
    var type:StoneType = .Black
    var sequence:Int = 0
    var name = ""
    var allMoves: [Move] = [Move]()
    
    func addMove(m:Move){
        m.groupName = name
        allMoves.append(m)
    }
}
