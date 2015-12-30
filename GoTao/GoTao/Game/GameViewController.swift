/**
 *
 * Copyright (c) 2015, MarkNote. (MIT Licensed)
 * https://github.com/marknote/MarknoteParser
 */

import UIKit

 class GameViewController: UIViewController {
    @IBOutlet weak var _lblTitle:UILabel!
    @IBOutlet weak var _goban:GobanView!
    
    var _currentMove = 0
    
    var _game:GameInfo = GameInfo()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let filepath = NSBundle.mainBundle().pathForResource("001", ofType: "sgf") {
    
            //reading
            do {
                let kifu = try NSString(contentsOfFile: filepath, encoding: NSUTF8StringEncoding)
                _game = SGFParser().parse(kifu as String)
                
                //_goban.moves = _game.allMoves
                showMoves()
                
            }
            catch {/* error handling here */}
        }
    }
    
    @IBAction func backClick(sender:UIBarItem){
        _currentMove -= 1
        if (_currentMove < 0){
            _currentMove = 0
        }
        showMoves()
    }
    
    @IBAction func forwardClick(sender:UIBarItem){
        _currentMove += 1
        if (_currentMove > _game.allMoves.count - 1){
            _currentMove = _game.allMoves.count - 1
        }
        showMoves()
    }
    func showMoves(){
        if _game.allMoves.count > 0 {
            let moves = _game.allMoves[0..<_currentMove]
            _goban.moves = Array(moves)
            _goban.setNeedsDisplay()
            _lblTitle.text = "\(_game.playerBlack) v \(_game.playerWhite)   \(_currentMove + 1) / \(_game.allMoves.count)"
        }
    }

}
