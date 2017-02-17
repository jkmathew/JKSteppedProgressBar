//
//  SteppedProgressBar.swift
//  JKSteppedProgressBar
//
//  Created by Johnykutty Mathew on 12/09/16.
//  Copyright © 2016 Johnykutty Mathew. All rights reserved.
//

import UIKit

public let SteppedProgressBarAutomaticDimension: CGFloat = -1

@IBDesignable
open class SteppedProgressBar: UIView {

    let paragraphStyle = NSMutableParagraphStyle()

    @IBInspectable open var activeColor: UIColor = UIColor.green {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable open var inactiveColor: UIColor = UIColor.gray {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable open var inactiveTextColor: UIColor = UIColor.gray {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable open var circleRadius: CGFloat = 20 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable open var circleSpacing: CGFloat = SteppedProgressBarAutomaticDimension {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable open var lineWidth: CGFloat = 2 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable open var currentTab: Int = 0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    private var actualSpacing: CGFloat {
        return (circleSpacing == SteppedProgressBarAutomaticDimension) ? (frame.width - 6.0 - (CGFloat(titles.count) * circleRadius)) / CGFloat(titles.count - 1) : circleSpacing
    }
    
    open var titles = ["One", "Two","Three", "Four","Five", "Six"] {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        paragraphStyle.alignment = .center
    }
 
    override open func draw(_ rect: CGRect) {
        let count = titles.count
        let context = UIGraphicsGetCurrentContext()
        
        if currentTab == 0 {
            _ = drawTabs(from: 0, to: count, color: inactiveColor, textColor: inactiveTextColor)
        }
        else if currentTab == count {
            _ = drawTabs(from: 0, to: count, color: activeColor, textColor: activeColor)
        }
        else {
            let first = drawTabs(from: 0, to: currentTab , color: activeColor, textColor: activeColor).end
            let second = drawTabs(from: currentTab, to: count, color: inactiveColor, textColor: inactiveTextColor).start
            let path = UIBezierPath()
            path.lineWidth = lineWidth
            
            path.move(to: first)
            path.addLine(to: second)
            context?.setStrokeColor(inactiveColor.cgColor)
            path.stroke()
        }
    }
    
    func drawTabs(from begin: Int, to end: Int, color: UIColor, textColor: UIColor) -> (start: CGPoint, end: CGPoint) {
        let startX =  bounds.midX - (CGFloat(titles.count - 1) * (actualSpacing + circleRadius) / 2.0)
        let x = startX + (actualSpacing + circleRadius) * CGFloat(begin)
        var point = CGPoint(x: x, y: bounds.midY)
        var start = point
        start.x -= circleRadius / 2.0
        
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        for i in begin..<end {
            draw(step: i, path: path, start : &point, textColor: textColor)
            if i != (end - 1) {
                //draw trailinng line
                point.x += actualSpacing
                path.addLine(to: point)
                point.x += circleRadius / 2.0
            }
        }
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(color.cgColor)
        path.stroke()
        return (start: start, end: point)
    }
    
    func draw(step i: Int, path: UIBezierPath, start point: inout CGPoint, textColor: UIColor) {
        //draw circle
        path.move(to: point)
        let buttonRect = circleRect(point, radius: circleRadius)
        let circlePath = UIBezierPath(ovalIn: buttonRect)
        path.append(circlePath)
        
        //draw index
        let index =  i
        let buttonTitle = "\(index + 1)"
        let font = UIFont.boldSystemFont(ofSize: 14.0)
        
        var attributes = [NSForegroundColorAttributeName : textColor, NSParagraphStyleAttributeName: paragraphStyle, NSFontAttributeName: font]
        let attributedButtonTitle = NSAttributedString(string: buttonTitle, attributes: attributes)
        drawString(attributedButtonTitle, center: point)
        
        var titleCenter = point
        titleCenter.y += circleRadius * 0.75
        let title = titles[index]
        attributes[NSFontAttributeName] = UIFont.boldSystemFont(ofSize: 12.0)
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        drawString(attributedTitle, center: titleCenter)
        
        point.x += circleRadius / 2.0
        path.move(to: point)
        
    }
    
    func drawString(_ string: NSAttributedString, center: CGPoint) {
        var rect = string.boundingRect(with: CGSize(width: 1000, height: 1000), options: .usesFontLeading, context: nil)
        let size = rect.size
        let origin = CGPoint(x: center.x - size.width / 2.0, y: center.y - size.height / 2.0)
        rect.origin = origin
        string.draw(in: rect)
        
    }
    
    func circleRect(_ center: CGPoint, radius: CGFloat) -> CGRect {
        let halfR = radius / 2.0
        let rect = CGRect(x: center.x - halfR, y: center.y - halfR, width: radius, height: radius)
        return rect
    }

}
