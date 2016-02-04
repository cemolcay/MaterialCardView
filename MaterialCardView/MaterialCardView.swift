//
//  MaterialCardView.swift
//  MaterialCardView
//
//  Created by Cem Olcay on 22/01/15.
//  Copyright (c) 2015 Cem Olcay. All rights reserved.
//

import UIKit

enum MaterialAnimationTimingFunction {
    case SwiftEnterInOut
    case SwiftExitInOut

    func timingFunction () -> CAMediaTimingFunction {
        switch self {

        case .SwiftEnterInOut:
            return CAMediaTimingFunction (controlPoints: 0.4027, 0, 0.1, 1)

        case .SwiftExitInOut:
            return CAMediaTimingFunction (controlPoints: 0.4027, 0, 0.2256, 1)
        }
    }
}

enum MaterialRippleLocation {
    case Center
    case TouchLocation
}


extension UIView {

    func addRipple (action: (()->Void)?) {
        addRipple(true, action: action)
    }

    func addRipple (
        withOverlay: Bool,
        action: (()->Void)?) {
            addRipple(
                UIColor.Gray(51, alpha: 0.1),
                duration: 0.9,
                location: .TouchLocation,
                withOverlay: withOverlay,
                action: action)
    }

    func addRipple (
        color: UIColor,
        duration: NSTimeInterval,
        location: MaterialRippleLocation,
        withOverlay: Bool,
        action: (()->Void)?) {

            let ripple = RippleLayer (
                superLayer: layer,
                color: color,
                animationDuration: duration,
                location: location,
                withOverlay: withOverlay,
                action: action)

            addTapGesture(1, action: { [unowned self] (tap) -> () in
                ripple.animate(tap.locationInView (self))
                action? ()
                })
    }
}

@objc public class RippleLayer: CALayer {


    // MARK: Properties

    var color: UIColor!
    var animationDuration: NSTimeInterval!
    var location: MaterialRippleLocation! = .TouchLocation

    var action: (()->Void)?
    var overlay: CALayer?



    // MARK: Animations

    lazy var rippleAnimation: CAAnimation = {
        let scale = CABasicAnimation (keyPath: "transform.scale")
        scale.fromValue = 1
        scale.toValue = 15

        let opacity = CABasicAnimation (keyPath: "opacity")
        opacity.fromValue = 0
        opacity.toValue = 1
        opacity.autoreverses = true
        opacity.duration = self.animationDuration / 2

        let anim = CAAnimationGroup ()
        anim.animations = [scale, opacity]
        anim.duration = self.animationDuration
        anim.timingFunction = MaterialAnimationTimingFunction.SwiftEnterInOut.timingFunction()

        return anim
        } ()

    lazy var overlayAnimation: CABasicAnimation = {
        let overlayAnim = CABasicAnimation (keyPath: "opacity")
        overlayAnim.fromValue = 1
        overlayAnim.toValue = 0
        overlayAnim.duration = self.animationDuration
        overlayAnim.timingFunction = MaterialAnimationTimingFunction.SwiftEnterInOut.timingFunction()

        return overlayAnim
        } ()



    // MARK: Lifecylce

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(layer: AnyObject) {
        super.init(layer: layer)
    }

    init (
        superLayer: CALayer,
        color: UIColor,
        animationDuration: NSTimeInterval,
        location: MaterialRippleLocation,
        withOverlay: Bool,
        action: (()->Void)?) {

            super.init()
            self.color = color
            self.animationDuration = animationDuration
            self.location = location
            self.action = action

            initRipple(superLayer)

            if withOverlay {
                initOverlay(superLayer)
            }
    }



    // MARK: Setup

    func initOverlay (superLayer: CALayer) {
        overlay = CALayer ()
        overlay!.frame = superLayer.frame
        overlay!.backgroundColor = UIColor.Gray(0, alpha: 0.05).CGColor
        overlay!.opacity = 0
        superLayer.addSublayer(overlay!)
    }

    func initRipple (superLayer: CALayer) {
        let size = min(superLayer.frame.size.width, superLayer.frame.size.height) / 2
        frame = CGRect (x: 0, y: 0, width: size, height: size)
        backgroundColor = color.CGColor
        opacity = 0
        cornerRadius = size/2

        masksToBounds = true
        superLayer.masksToBounds = true
        superLayer.addSublayer(self)
    }



    // MARK: Animate

    func animate (touchLocation: CGPoint) {

        CATransaction.begin()
        CATransaction.setValue(true, forKey: kCATransactionDisableActions)
        if location == .TouchLocation {
            position = touchLocation
        } else {
            position = superlayer!.position
        }
        CATransaction.commit()

        let animationGroup = rippleAnimation as! CAAnimationGroup
        if let over = overlay {
            over.addAnimation(overlayAnimation, forKey: "overlayAnimation")
        }

        addAnimation(animationGroup, forKey: "rippleAnimation")
    }

}


extension UIColor {

    class func CardHeaderColor () -> UIColor {
        return Gray(242)
    }

    class func CardCellColor () -> UIColor {
        return Gray(249)
    }

    class func CardBorderColor () -> UIColor {
        return Gray(200)
    }


    class func RippleColor () -> UIColor {
        return UIColor.Gray(51, alpha: 0.1)
    }

    class func ShadowColor () -> UIColor {
        return UIColor.Gray(51)
    }


    class func TitleColor () -> UIColor {
        return Gray(51)
    }

    class func TextColor () -> UIColor {
        return Gray(144)
    }
}

extension UIFont {

    class func TitleFont () -> UIFont {
        return AvenirNextDemiBold(15)
    }

    class func TextFont () -> UIFont {
        return AvenirNextRegular(13)
    }
}


@objc public class MaterialCardAppearance : NSObject {

    var headerBackgroundColor: UIColor
    var cellBackgroundColor: UIColor
    var borderColor: UIColor

    var titleFont: UIFont
    var titleColor: UIColor

    var textFont: UIFont
    var textColor: UIColor

    var shadowColor: UIColor
    var rippleColor: UIColor
    var rippleDuration: NSTimeInterval

    init (
        headerBackgroundColor: UIColor,
        cellBackgroundColor: UIColor,
        borderColor: UIColor,
        titleFont: UIFont,
        titleColor: UIColor,
        textFont: UIFont,
        textColor: UIColor,
        shadowColor: UIColor,
        rippleColor: UIColor,
        rippleDuration: NSTimeInterval) {

            self.headerBackgroundColor = headerBackgroundColor
            self.cellBackgroundColor = cellBackgroundColor
            self.borderColor = borderColor

            self.titleFont = titleFont
            self.titleColor = titleColor

            self.textFont = textFont
            self.textColor = textColor

            self.shadowColor = shadowColor
            self.rippleColor = rippleColor
            self.rippleDuration = rippleDuration
    }
}

@objc public class MaterialCardCell: UIView {


    // MARK: Constants

    let itemPadding: CGFloat = 16



    // MARK: Properties

    private var parentCard: MaterialCardView!

    var bottomLine: UIView?



    // MARK: Lifecyle

    required public init?(coder aDecoder: NSCoder) {
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
            textColor: parentCard.appearance.titleColor,
            textAlignment: .Left,
            font: parentCard.appearance.titleFont)
        addView(title)
    }

    func addText (text: String) {
        let text = UILabel (
            x: itemPadding,
            y: h,
            width: parentCard.w - itemPadding*2,
            padding: itemPadding,
            text: text,
            textColor: parentCard.appearance.textColor,
            textAlignment: .Left,
            font: parentCard.appearance.textFont)
        addView(text)
    }

    func addView (view: UIView) {
        addSubview(view)
        h += view.h
    }


    func drawBottomLine () {
        if let _ = bottomLine {
            return
        }

        bottomLine = UIView (x: 0, y: h - 1, w: w, h: 1)
        bottomLine!.backgroundColor = parentCard.appearance.borderColor
        addSubview(bottomLine!)
    }

    func removeBottomLine () {
        if let l = bottomLine {
            l.removeFromSuperview()
            bottomLine = nil
        }
    }
}

@objc public class MaterialCardView: UIView {


    // MARK: Constants

    public let cardRadius: CGFloat = 3
    public let rippleDuration: NSTimeInterval = 0.9
    public let shadowOpacity: Float = 0.5
    public let shadowRadius: CGFloat = 1.5

    public let estimatedRowHeight: CGFloat = 53
    public let estimatedHeaderHeight: CGFloat = 40



    // MARK: Properties

    public var appearance: MaterialCardAppearance!
    public var items: [MaterialCardCell] = []
    public var contentView: UIView!



    // MARK: Lifecylce

    // required public init?(coder aDecoder: NSCoder) {
    //     super.init(coder: aDecoder)
    // }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

    public convenience init(frame: CGRect, value: MaterialCardAppearance!) {
      self.init(frame: frame);
      h = 0
      if let valueConst = value {
        // http://stackoverflow.com/questions/27096863/how-to-check-for-an-undefined-or-null-variable-in-swift
        self.appearance = value
      } else {
        self.appearance = defaultAppearance()
      }

      contentView = UIView (superView: self)
      addSubview(contentView)
    }



    // MARK: Setup

    func defaultAppearance () -> MaterialCardAppearance {
        return MaterialCardAppearance (
            headerBackgroundColor: UIColor.CardHeaderColor(),
            cellBackgroundColor: UIColor.CardCellColor(),
            borderColor: UIColor.CardBorderColor(),
            titleFont: UIFont.TitleFont(),
            titleColor: UIColor.TitleColor(),
            textFont: UIFont.TextFont(),
            textColor: UIColor.TextColor(),
            shadowColor: UIColor.ShadowColor(),
            rippleColor: UIColor.RippleColor(),
            rippleDuration: rippleDuration)
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

        contentView.size = size
        materialize()
    }

    public func materialize () {

        addShadow(
            CGSize (width: 0, height: 1),
            radius: shadowRadius,
            color: UIColor.ShadowColor(),
            opacity: shadowOpacity,
            cornerRadius: cardRadius)

        contentView.setCornerRadius(cardRadius)
    }

    public func shadowRadiusAnimation (to: CGFloat) {

        let radiusAnim = CABasicAnimation (keyPath: "shadowRadius")
        radiusAnim.fromValue = layer.shadowRadius
        radiusAnim.toValue = to
        radiusAnim.duration = rippleDuration
        radiusAnim.timingFunction = MaterialAnimationTimingFunction.SwiftEnterInOut.timingFunction()
        radiusAnim.autoreverses = true

        let offsetAnim = CABasicAnimation (keyPath: "shadowOffset")
        offsetAnim.fromValue = NSValue (CGSize: layer.shadowOffset)
        offsetAnim.toValue = NSValue (CGSize: layer.shadowOffset + CGSize (width: 0, height: to))
        offsetAnim.duration = rippleDuration
        offsetAnim.timingFunction = MaterialAnimationTimingFunction.SwiftEnterInOut.timingFunction()
        offsetAnim.autoreverses = true

        let anim = CAAnimationGroup ()
        anim.animations = [radiusAnim, offsetAnim]
        anim.duration = rippleDuration*2
        anim.timingFunction = MaterialAnimationTimingFunction.SwiftEnterInOut.timingFunction()

        layer.addAnimation(anim, forKey: "shadowAnimation")
    }

    override public func addRipple(action: (() -> Void)?) {
        contentView.addRipple(
            appearance.rippleColor,
            duration: appearance.rippleDuration,
            location: .TouchLocation,
            withOverlay: false,
            action: { [unowned self] sender in
                self.shadowRadiusAnimation(6)
                action? ()
            })
    }



    // MARK: Add Cell

    public func addHeader (title: String) {
        let cell = MaterialCardCell (card: self)
        cell.backgroundColor = appearance.headerBackgroundColor

        cell.addTitle(title)
        cell.h = max (cell.h, estimatedHeaderHeight)

        items.insert(cell, atIndex: 0)
        add(cell)
    }

    public func addHeaderView (view: UIView) {
        let cell = MaterialCardCell (card: self)
        cell.backgroundColor = appearance.headerBackgroundColor

        cell.addView(view)

        items.insert(cell, atIndex: 0)
        add(cell)
    }


    public func addFooter (title: String) {
        let cell = MaterialCardCell (card: self)
        cell.backgroundColor = appearance.headerBackgroundColor

        cell.addTitle(title)
        cell.h = max (cell.h, estimatedHeaderHeight)

        items.insert(cell, atIndex: items.count)
        add(cell)
    }

    public func addFooterView (view: UIView) {
        let cell = MaterialCardCell (card: self)
        cell.backgroundColor = appearance.headerBackgroundColor

        cell.addView(view)

        items.insert(cell, atIndex: items.count)
        add(cell)
    }


    public func addCell (text: String, action: (()->Void)? = nil) {
        let cell = MaterialCardCell (card: self)
        cell.backgroundColor = appearance.cellBackgroundColor

        cell.addText(text)
        cell.h = max (cell.h, estimatedRowHeight)

        if let act = action {
            cell.addRipple(
                appearance.rippleColor,
                duration: appearance.rippleDuration,
                location: .TouchLocation,
                withOverlay: true,
                action: act)
        }

        items.append(cell)
        add(cell)
    }

    public func addCellView (view: UIView, action: (()->Void)? = nil) {
        let cell = MaterialCardCell (card: self)
        cell.backgroundColor = appearance.cellBackgroundColor

        cell.addView(view)

        if let act = action {
            cell.addRipple(
                appearance.rippleColor,
                duration: appearance.rippleDuration,
                location: .TouchLocation,
                withOverlay: true,
                action: act)
        }

        items.append(cell)
        add(cell)
    }

    public func addCell (cell: MaterialCardCell) {
        cell.backgroundColor = appearance.cellBackgroundColor

        items.append(cell)
        add(cell)
    }


    private func add (cell: MaterialCardCell) {
        contentView.addSubview(cell)
        h += cell.h

        updateFrame()
    }



    // MARK: Remove Cell

    func removeCellAtIndex (index: Int) {
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
