
/**
*
* Copyright (c) 2015, MarkNote. (MIT Licensed)
* https://github.com/marknote/MarknoteParser
*/

import UIKit

class GobanView: UIView {

    override func drawRect(rect: CGRect) {
        
        let ctx = UIGraphicsGetCurrentContext()
        let rec = CGContextGetClipBoundingBox(ctx)
        let w = rec.size.width;
        //back ground image
        let background = UIImage(named:"board_back")
        
        CGContextDrawImage(ctx, rec, background!.CGImage )
        //draw lines
        CGContextSetRGBStrokeColor(ctx, 0, 0, 0, 1)
        CGContextSetLineWidth(ctx, 0.4)
        CGContextBeginPath(ctx)
        let space = w/20.0
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
        //draw labels
        
        // nine dots
        
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
    

}
