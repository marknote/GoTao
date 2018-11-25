/**
 *
 * Copyright (c) 2015, MarkNote. (MIT Licensed)
 * https://github.com/marknote/GoTao
 */

import UIKit

 class GameViewController: UIViewController {
    @IBOutlet weak var _lblTitle:UILabel!
    @IBOutlet weak var _goban:GobanView!
    
    //var _currentMove = 0
    
    var _game:GameInfo = GameInfo()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let filepath = Bundle.main.path(forResource: "001", ofType: "sgf") {
    
            //reading
            do {
                let kifu = try NSString(contentsOfFile: filepath, encoding: String.Encoding.utf8.rawValue)
                _game = SGFParser().parse(kifu as String)
                
                //_goban.moves = _game.allMoves
                showMoves()
                
            }
            catch {/* error handling here */}
        }
    }
    
    @IBAction func backClick(_ sender:UIBarItem){
        _game.goBack()
        showMoves()
    }
    
    @IBAction func forwardClick(_ sender:UIBarItem){
        _game.goForward()
        showMoves()
    }
    func showMoves(){
        if _game.allMoves.count > 0 {            
            //_goban.moves = _game.currentMoves()
            //_game.assignGroups()
            _game.moveTocurrent()
            _goban.moves = _game.currentMoves()
            
            _goban.setNeedsDisplay()
            _lblTitle.text = "\(_game.playerBlack) v \(_game.playerWhite)   \(_game.currentMove + 1) / \(_game.allMoves.count)"
        }
    }

}
