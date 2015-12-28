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
        let kifu = ";B[qd];W[dc];B[pq];"
        let result = parser.parse(kifu)
        assert(3==result.allMoves.count)
        
        
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
