
/**
*
* Copyright (c) 2015, MarkNote. (MIT Licensed)
* https://github.com/marknote/MarknoteParser
*/

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class GobanView: UIView {
    var moves:[Move]?

    override func draw(_ rect: CGRect) {
        
        let ctx = UIGraphicsGetCurrentContext()
        let rec = ctx?.boundingBoxOfClipPath
        let w = rec?.size.width;
        //back ground image
        let background = UIImage(named:"board_back")
        
        ctx?.draw(background!.cgImage!, in: rec!)
        let space = w! / 20.0
        drawLines(ctx!,space:space,w:w!)
        drawDots(ctx!,space:space)
        if (moves != nil  && moves?.count > 0)  {
            drawMoves(ctx!, stoneSize: space)
        }
        
    }
    func drawLines(_ ctx:CGContext,space:CGFloat, w:CGFloat){
        ctx.setStrokeColor(red: 0, green: 0, blue: 0, alpha: 1)
        ctx.setLineWidth(0.4)
        ctx.beginPath()
        
        for i in 0...18
        {
            
            ctx.move(to: CGPoint(x: (CGFloat(i + 1))*space, y: space))
            ctx.addLine(to: CGPoint(x: (CGFloat(i + 1))*space, y: w - space))
            ctx.strokePath()
        }
        for i in 0...18
        {
            
            ctx.move(to: CGPoint(x: space, y: (CGFloat(i + 1))*space));
            ctx.addLine(to: CGPoint(x: w - space, y: (CGFloat(i + 1))*space));
            ctx.strokePath();
        }

    }
    func drawDots(_ ctx:CGContext,space:CGFloat){
        for i in 0...2 {
            for j in 0...2 {
                ctx.beginPath();
                
                let frame = CGRect(x:CGFloat(1 + 3 + 6*i) * space - 0.5 * space,
                                   y:CGFloat(1 + 3 + 6*j) * space - 0.5 * space,
                                   width:space,
                                   height:space)
                
                ctx.addEllipse(in:frame)
                
                ctx.strokePath();
            }
        }

    }
    
    func drawMoves(_ ctx:CGContext,stoneSize:CGFloat ){
        // chess
        let imgBlack = UIImage(named: "Black.png")
        let imgWhite = UIImage(named: "White.png")
       
        let  count = moves?.count
        let font = UIFont(name: "Helvetica Bold", size: 8.0)
        let textColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.8)  
        let textFontAttributes = [
            NSAttributedStringKey.font : font!,
            NSAttributedStringKey.foregroundColor: textColor
        ]

        for i in 0..<count! {
            let move = moves![i]
            if move.isDead {
                continue
            }
            let imageRect = CGRect( x: (CGFloat(move.location.x) + 0.5)*stoneSize,
                                    y: (CGFloat(move.location.y) + 0.5)*stoneSize,
                                    width: stoneSize,
                                    height: stoneSize);
            if move.type == .white {
                ctx.draw((imgWhite?.cgImage)!, in: imageRect)
            } else {
                ctx.draw((imgBlack?.cgImage)!, in: imageRect)
                
            }
            if move.groupName.characters.count > 0 {
                ctx.setStrokeColor(red: 1, green: 0, blue: 0, alpha: 1)
                let p = CGPoint(x: (CGFloat(move.location.x) + 0.5)*stoneSize,
                                y: (CGFloat(move.location.y) + 0.5)*stoneSize);
                (move.groupName as NSString).draw(at: p, withAttributes:textFontAttributes)
            }
        }
        
        if count > 0
        {
            let move = moves![count! - 1]
            ctx.setLineWidth(1.8)
            
            ctx.setStrokeColor(red: 0, green: 1, blue: 0, alpha: 1)
            
            ctx.beginPath()
            let frame = CGRect(x:CGFloat(move.location.x) * stoneSize + 0.5 * stoneSize,
                               y:CGFloat(move.location.y) * stoneSize + 0.5 * stoneSize,
                               width:stoneSize,
                               height:stoneSize)
            
            ctx.addEllipse(in:frame)
            
            ctx.strokePath()
        }
    }

}
