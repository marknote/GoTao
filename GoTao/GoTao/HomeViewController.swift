/**
 *
 * Copyright (c) 2015, MarkNote. (MIT Licensed)
 * https://github.com/marknote/MarknoteParser
 */

import UIKit

 open class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var _games:[GameInfo] = [GameInfo]()
    @IBOutlet weak var _tblGames:UITableView!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        let game1 = GameInfo()
        game1.title = "第一届日本最强者决定战吴清源对高川格"
        game1.metaInfo = "对弈时间：1957年2月20日"
        _games.append(game1)
        
        let game2 = GameInfo()
        game2.title = "MarkNote对弈李昌镐"
        game2.metaInfo = "对弈时间：2015年12月28日"
        _games.append(game2)
    }
    
    @objc open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _games.count
    }
    
    @objc open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let game = _games[row]
        
        let cell = _tblGames.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
        cell.textLabel?.text = game.title
        cell.detailTextLabel?.text = game.metaInfo
        return cell
        
    }
}

