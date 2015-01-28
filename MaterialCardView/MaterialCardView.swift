//
//  MaterialCardView.swift
//  MaterialCardView
//
//  Created by Cem Olcay on 22/01/15.
//  Copyright (c) 2015 Cem Olcay. All rights reserved.
//

import UIKit


extension UIView {
    
    
    // MARK: CALayer
    
    func materialize () {
        layer.cornerRadius = 1
        layer.shadowOffset = CGSize (width: 0, height: 1)
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.5
        layer.shadowColor = UIColor.TitleColor().CGColor
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).CGPath
        
        layer.masksToBounds = false
    }
    
    
    
    // MARK: CAAnimation
    
    func shadowDepthTo (to: CGFloat) {
        let radiusAnim = CABasicAnimation (keyPath: "shadowRadius")
        radiusAnim.fromValue = layer.shadowRadius
        radiusAnim.toValue = to
        
        let offsetAnim = CABasicAnimation (keyPath: "shadowOffset.height")
        offsetAnim.fromValue = layer.shadowOffset.height
        offsetAnim.toValue = to
        
        let anim = CAAnimationGroup ()
        anim.animations = [radiusAnim, offsetAnim]
        anim.duration = UIViewAnimationDuration
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        anim.removedOnCompletion = false
        anim.delegate = self
        
        layer.addAnimation(anim, forKey: "materialShadow")
    }
    
    func materialSizeTo (to: CGSize) {
        let shadowFrame = CABasicAnimation (keyPath: "shadowPath")
        shadowFrame.fromValue = layer.shadowPath
        shadowFrame.toValue = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).CGPath

        let layerFrame = CABasicAnimation (keyPath: "frame.size")
        layerFrame.fromValue = NSValue (CGSize: size)
        layerFrame.toValue = NSValue (CGSize: to)
        
        let anim = CAAnimationGroup ()
        anim.animations = [shadowFrame, layerFrame]
        anim.duration = UIViewAnimationDuration
        anim.timingFunction = CAMediaTimingFunction (name: kCAMediaTimingFunctionEaseInEaseOut)
        anim.removedOnCompletion = false
        anim.delegate = self
        
        layer.addAnimation(anim, forKey: "sizeTo")
    }
    
    public override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        if flag {
            if let anim = layer.animationForKey("materialShadow") {
                let group = anim as CAAnimationGroup
                let radius = group.animations[0] as CABasicAnimation
                let offset = group.animations[1] as CABasicAnimation
                
                layer.shadowRadius = radius.toValue! as CGFloat
                layer.shadowOffset.height = offset.toValue! as CGFloat
            }
            
            if let anim = layer.animationForKey("sizeTo") {
                let group = anim as CAAnimationGroup
                let shadowFrame = group.animations[0] as CABasicAnimation
                let layerFrame = group.animations[1] as CABasicAnimation
                
                layer.shadowPath = shadowFrame.toValue! as CGPath
                layer.frame.size = (layerFrame.toValue! as NSValue).CGSizeValue()
            }
        }
    }
    
    
    
    // MARK: UIView Animation

    func materialAnimate (animations: ()->Void) {
        UIView.animateWithDuration(
            UIViewAnimationDuration,
            delay: 0,
            options: .CurveEaseInOut,
            animations: animations,
            completion: nil)
    }
    
    func materialMoveTo (to: CGPoint) {
        materialAnimate {
            self.position = to
        }
    }
    
    func materialFrameTo (to: CGRect) {
        materialAnimate {
            self.frame = to
        }
    }
    
}

extension UIColor {
    
    class func CardHeaderColor () -> UIColor {
        return UIColor.RGBColor(242, g: 242, b: 242)
    }
    
    class func CardCellColor () -> UIColor {
        return UIColor.RGBColor(249, g: 249, b: 249)
    }
    
    class func CardBorderColor () -> UIColor {
        return UIColor.RGBColor(200, g: 199, b: 204)
    }
    
    
    class func TitleColor () -> UIColor {
        return UIColor.RGBColor(51, g: 51, b: 51)
    }
    
    class func TextColor () -> UIColor {
        return RGBColor(144, g: 144, b: 144)
    }
}

extension UIFont {
    
    class func AvenirNext (type: FontType, size: CGFloat) -> UIFont {
        return UIFont.Font(UIFont.FontName.AvenirNext, type: type, size: size)
    }
    
    class func AvenirNextDemiBold (size: CGFloat) -> UIFont {
        return AvenirNext(UIFont.FontType.DemiBold, size: size)
    }
    
    class func AvenirNextRegular (size: CGFloat) -> UIFont {
        return AvenirNext(UIFont.FontType.Regular, size: size)
    }
}


struct MaterialCardAppeareance {
    
    var headerBackgroundColor: UIColor
    var cellBackgroundColor: UIColor
    var borderColor: UIColor
    
    var titleFont: UIFont
    var titleColor: UIColor
    
    var textFont: UIFont
    var textColor: UIColor
    
    init (
        headerBackgroundColor: UIColor,
        cellBackgroundColor: UIColor,
        borderColor: UIColor,
        titleFont: UIFont,
        titleColor: UIColor,
        textFont: UIFont,
        textColor: UIColor) {
        self.headerBackgroundColor = headerBackgroundColor
        self.cellBackgroundColor = cellBackgroundColor
        self.borderColor = borderColor
        
        self.titleFont = titleFont
        self.titleColor = titleColor
        
        self.textFont = textFont
        self.textColor = textColor
    }
}

class MaterialCardCell: UIView {
    
    
    // MARK: Constants
    
    let itemPadding: CGFloat = 16
    
    
    
    // MARK: Properties
    
    private var parentCard: MaterialCardView!
    
    var bottomLine: UIView?
    
    
    
    // MARK: Lifecyle
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (card: MaterialCardView) {
        super.init(frame: CGRect(x: 0, y: 0, width: card.w, height: 0))
        parentCard = card
    }
    
    
    
    // MARK: Create
    
    func addTitle (title: String) {
        let title = UILabel (
            x: itemPadding,
            y: h,
            width: parentCard.w - itemPadding*2,
            padding: itemPadding,
            text: title,
            textColor: parentCard.appeareance.titleColor,
            textAlignment: .Left,
            font: parentCard.appeareance.titleFont)
        addView(title)
    }
    
    func addText (text: String) {
        let text = UILabel (
            x: itemPadding,
            y: h,
            width: parentCard.w - itemPadding*2,
            padding: itemPadding,
            text: text,
            textColor: parentCard.appeareance.textColor,
            textAlignment: .Left,
            font: parentCard.appeareance.textFont)
        addView(text)
    }

    func addView (view: UIView) {
        addSubview(view)
        h += view.h
    }

    
    func drawBottomLine () {
        if let line = bottomLine {
            return
        }
        
        bottomLine = UIView (x: 0, y: h - 1, w: w, h: 1)
        bottomLine!.backgroundColor = parentCard.appeareance.borderColor
        addSubview(bottomLine!)
    }
    
    func removeBottomLine () {
        if let l = bottomLine {
            l.removeFromSuperview()
            bottomLine = nil
        }
    }
}

class MaterialCardView: UIView {
    
    
    // MARK: Constants
    
    let cardPadding: CGFloat = 10
    
    let estimatedRowHeight: CGFloat = 53
    let estimatedHeaderHeight: CGFloat = 40
    
    
    
    // MARK: Properties

    var appeareance: MaterialCardAppeareance!
    var items: [MaterialCardCell] = []
    
    
    
    // MARK: Lifecylce
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init () {
        super.init()
        defaultInit()
    }
    
    
    init (x: CGFloat, y: CGFloat, w: CGFloat) {
        super.init(frame: CGRect (x: x, y: y, width: w, height: 0))
        defaultInit()
    }
    
    func defaultInit () {
        h = 0
        appeareance = defaultAppeareance()
    }
    
    
    
    // MARK: Setup
    
    func defaultAppeareance () -> MaterialCardAppeareance {
        return MaterialCardAppeareance (
            headerBackgroundColor: UIColor.CardHeaderColor(),
            cellBackgroundColor: UIColor.CardCellColor(),
            borderColor: UIColor.CardBorderColor(),
            titleFont: UIFont.AvenirNextDemiBold(18),
            titleColor: UIColor.TitleColor(),
            textFont: UIFont.AvenirNextRegular(15),
            textColor: UIColor.TextColor())
    }
    
    
    
    // MARK: Card
    
    func updateFrame () {
        var current = 0
        var currentY: CGFloat = 0
        for item in items {
            item.y = currentY
            currentY += item.h
            
            item.removeBottomLine()
            if ++current < items.count {
                item.drawBottomLine()
            }
        }
        
        materialize()
    }

    
    
    // MARK: Add Cell
    
    func addHeader (title: String) {
        let cell = MaterialCardCell (card: self)
        cell.backgroundColor = appeareance.headerBackgroundColor
        
        cell.addTitle(title)
        cell.h = max (cell.h, estimatedHeaderHeight)
        
        items.insert(cell, atIndex: 0)
        add(cell)
    }
    
    func addHeader (view: UIView) {
        let cell = MaterialCardCell (card: self)
        cell.backgroundColor = appeareance.headerBackgroundColor

        cell.addView(view)
        cell.h = max (cell.h, estimatedHeaderHeight)
        
        items.insert(cell, atIndex: 0)
        add(cell)
    }
    
    
    func addFooter (title: String) {
        let cell = MaterialCardCell (card: self)
        cell.backgroundColor = appeareance.headerBackgroundColor
        
        cell.addTitle(title)
        cell.h = max (cell.h, estimatedHeaderHeight)
        
        items.insert(cell, atIndex: items.count)
        add(cell)
    }
    
    func addFooter (view: UIView) {
        let cell = MaterialCardCell (card: self)
        cell.backgroundColor = appeareance.headerBackgroundColor
        
        cell.addView(view)
        cell.h = max (cell.h, estimatedHeaderHeight)
        
        items.insert(cell, atIndex: items.count)
        add(cell)
    }
    
    
    func addCell (title: String) {
        let cell = MaterialCardCell (card: self)
        cell.backgroundColor = appeareance.cellBackgroundColor
        
        cell.addTitle(title)
        cell.h = max (cell.h, estimatedRowHeight)
        
        items.append(cell)
        add(cell)
    }
    
    func addCell (view: UIView) {
        let cell = MaterialCardCell (card: self)
        cell.backgroundColor = appeareance.cellBackgroundColor
        
        cell.addView(view)
        cell.h = max (cell.h, estimatedRowHeight)
        
        items.append(cell)
        add(cell)
    }
    
    func addCell (cell: MaterialCardCell) {
        cell.backgroundColor = appeareance.cellBackgroundColor
        cell.h = max (cell.h, estimatedRowHeight)
        
        items.append(cell)
        add(cell)
    }
    
    
    private func add (cell: MaterialCardCell) {
        addSubview(cell)
        h += cell.h
        
        updateFrame()
    }
    
    
    
    // MARK: Remove Cell
    
    func removeCell (index: Int) {
        if index < items.count {
            let cell = items[index]
            removeCell(cell)
        }
    }
    
    func removeCell (cell: MaterialCardCell) {
        cell.removeFromSuperview()
        items.removeObject(cell)
        
        h -= cell.h
        updateFrame()
    }
}
