/**
 *
 * Copyright (c) 2015, MarkNote. (MIT Licensed)
 * https://github.com/marknote/MarknoteParser
 */

import UIKit

 class GameViewController: UIViewController {
    @IBOutlet weak var _lblTitle:UILabel!
    @IBOutlet weak var _goban:GobanView!
    
    var _game:GameInfo = GameInfo()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let filepath = NSBundle.mainBundle().pathForResource("001", ofType: "sgf") {
    
            //reading
            do {
                let kifu = try NSString(contentsOfFile: filepath, encoding: NSUTF8StringEncoding)
                _game = SGFParser().parse(kifu as String)
                _lblTitle.text = "\(_game.playerBlack) v \(_game.playerWhite)"
                _goban.moves = _game.allMoves
                
                
            }
            catch {/* error handling here */}
        }

    }
}
