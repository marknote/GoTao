
/**
*
* Copyright (c) 2015, MarkNote. (MIT Licensed)
* https://github.com/marknote/MarknoteParser
*/

import UIKit

class GobanView: UIView {
    var moves:[Move]?

    override func drawRect(rect: CGRect) {
        
        let ctx = UIGraphicsGetCurrentContext()
        let rec = CGContextGetClipBoundingBox(ctx)
        let w = rec.size.width;
        //back ground image
        let background = UIImage(named:"board_back")
        
        CGContextDrawImage(ctx, rec, background!.CGImage )
        let space = w/20.0
        drawLines(ctx!,space:space,w:w)
        drawDots(ctx!,space:space)
        if (moves != nil  && moves?.count > 0)  {
            drawMoves(ctx!, stoneSize: space)
        }
        
    }
    func drawLines(ctx:CGContext,space:CGFloat, w:CGFloat){
        CGContextSetRGBStrokeColor(ctx, 0, 0, 0, 1)
        CGContextSetLineWidth(ctx, 0.4)
        CGContextBeginPath(ctx)
        
        for(var i=0;i<=18;i++)
        {
            
            CGContextMoveToPoint(ctx, (CGFloat(i+1))*space, space)
            CGContextAddLineToPoint(ctx, (CGFloat(i+1))*space, w-space)
            CGContextStrokePath(ctx)
        }
        for(var i=0;i<=18;i++)
        {
            
            CGContextMoveToPoint(ctx, space,(CGFloat(i+1))*space);
            CGContextAddLineToPoint(ctx,w-space, (CGFloat(i+1))*space);
            CGContextStrokePath(ctx);
        }

    }
    func drawDots(ctx:CGContext,space:CGFloat){
        for (var i=0;i<=2;i++)
        {
            for(var j=0;j<=2;j++)
            {
                CGContextBeginPath(ctx);
                
                CGContextAddArc(ctx, (CGFloat(1+3+6*i))*space ,CGFloat(1+3+6*j)*space, 2, 0, CGFloat(2.0*M_PI), 1);
                
                CGContextStrokePath(ctx);
            }
        }

    }
    
    func drawMoves(ctx:CGContext,stoneSize:CGFloat ){
        // chess
        let imgBlack = UIImage(named: "Black.png")
        let imgWhite = UIImage(named: "White.png")
       
        let  count = moves?.count
        
        let font = UIFont(name: "Helvetica Bold", size: 14.0)
    
         let textColor = UIColor(colorLiteralRed: 1.0, green: 0.0, blue: 0.0, alpha: 0.8)

        
        let textFontAttributes = [
            NSFontAttributeName : font!,
            NSForegroundColorAttributeName: textColor
        ]

        for (var i = 0; i < count; i++ )
        {
            let move = moves![i]
            let imageRect = CGRectMake( (CGFloat(move.location.x)+0.5)*stoneSize,(CGFloat(move.location.y)+0.5)*stoneSize, stoneSize, stoneSize);
            if move.type == .White
            {
                CGContextDrawImage(ctx, imageRect, imgWhite?.CGImage)
            }else
            {
                CGContextDrawImage(ctx, imageRect, imgBlack?.CGImage )
                
            }
            if move.groupName.characters.count > 0 {
                //CGContextSetTextMatrix(ctx, CGAffineTransformMakeScale(1.0, -1.0))
                CGContextSetRGBStrokeColor(ctx, 1, 0, 0, 1)
                let p = CGPointMake((CGFloat(move.location.x)+0.5)*stoneSize,(CGFloat(move.location.y)+0.5)*stoneSize);
                (move.groupName as NSString).drawAtPoint(p, withAttributes:textFontAttributes)
            }
        }
        
        if count > 0
        {
            let move = moves![count! - 1]
            CGContextSetLineWidth(ctx, 1.8)
            
            CGContextSetRGBStrokeColor(ctx, 0, 1, 0, 1)
            
            CGContextBeginPath(ctx)
            CGContextAddArc(ctx,
                CGFloat(move.location.x+1) * stoneSize,
                CGFloat(move.location.y+1) * stoneSize, 3, 0, CGFloat(2.0*M_PI), 0)
            CGContextStrokePath(ctx)
        }
    }

}
