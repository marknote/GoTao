/**
 *
 * Copyright (c) 2015, MarkNote. (MIT Licensed)
 * https://github.com/marknote/MarknoteParser
 */

import XCTest
@testable import GoTao

class GoTaoTests: XCTestCase {
    let parser = SGFParser()
    func testKifuCount() {
        let kifu = "(;;B[qd];W[dc];B[pq];)"
        let result = parser.parse(kifu)
        assert(3==result.allMoves.count)
        assert(result.allMoves[0].type == .Black, "The 1st move is black")
        assert(result.allMoves[1].type == .White, "The 2nd move is white")
        assert(result.allMoves[2].type == .Black, "The 3rd move is black")
    }
    
    func testKifuMetaInfo() {
        let kifu = "(;PB[本因坊秀策]\nBR[六段]\nPW[林柏荣门人]\nWR[七段]\nPC[江户御城，日本]\nRE[共241手，黑胜7目]\nDT[1851-11-17]"
        let game = parser.parse(kifu)
        assert(game.playerBlack == "本因坊秀策" )
        assert(game.playerWhite == "林柏荣门人" )
        assert(game.rankBlack == "六段" )
        assert(game.rankWhite == "七段" )
        assert(game.result == "共241手，黑胜7目" )
        assert(game.date == "1851-11-17")
        
    }
    
    func testIsConnected(){
        let m1 = Move(step:"B[aa]")
        let m2 = Move(step:"B[ab]")
        let m3 = Move(step:"W[ba]")
        assert(m1.isConnectedTo(m2),"m1 is connected to m2")
        assert(!m1.isConnectedTo(m3),"m1 is not connected to m3")
    }
    
    func testAssignedGroups(){
        let kifu = "(;;B[aa];W[ab];B[ca];W[bb];B[ba])"
        let game = parser.parse(kifu)
        game.currentMove = 4
        let groups = game.assignGroups()
        assert(groups.count == 2)
        assert(game.allMoves[0].groupName == "B1")
        assert(game.allMoves[2].groupName == "B1")
        assert(game.allMoves[1].groupName == "W2")
    }
    
    func testLocationEqual(){
        let l1 = Location(x:5,y:5)
        let l2 = Location(x:5,y:5)
        let l3 = Location(x:5,y:6)
        assert( l1.isEqual(l2))
        assert( !l1.isEqual(l3))
    }
    
    func testLocationIsConnectTo(){
        let l1 = Location(x:5,y:5)
        let l2 = Location(x:5,y:5)
        let l3 = Location(x:5,y:6)
        assert( !l1.isConnectedTo(l2))
        assert( l1.isConnectedTo(l3))
    }
    
    func testLibertyOne(){
        let kifu = "(;;B[qq])"
        let game = parser.parse(kifu)
        game.currentMove = 0
        let groups = game.assignGroups()
        assert(groups.count == 1)
        assert(groups[0].caculateLiberty(game.occupiedLocations()) == 4)
    }
    func testLibertyTwo(){
        let kifu = "(;;B[qq];B[qr])"
        let game = parser.parse(kifu)
        game.currentMove = 1
        let groups = game.assignGroups()
        assert(groups.count == 1)
        assert(groups[0].caculateLiberty(game.occupiedLocations()) == 6)
    }
    
    func testLibertyThree(){
        let kifu = "(;;B[qq];B[qr];W[qp];W[rq];W[rr];W[qs];W[pr];W[pq])"
        let game = parser.parse(kifu)
        game.currentMove = 7
        let groups = game.assignGroups()
        //assert(groups.count == 2)
        assert(groups[2].caculateLiberty(game.occupiedLocations()) == 0)
    }
    
    
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
}
