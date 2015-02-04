//
//  ViewController.swift
//  MaterialCardView
//
//  Created by Cem Olcay on 22/01/15.
//  Copyright (c) 2015 Cem Olcay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var v: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        materialDemo()
    }
    
    func cornerise () {
        
        let c5 = shadowAndCorner(5)
        view.addSubview(c5)
        
        let c3 = shadowAndCorner(3)
        c3.top = c5.botttomWithOffset(10)
        view.addSubview(c3)
        
        let c2 = shadowAndCorner(2)
        c2.top = c3.botttomWithOffset(10)
        view.addSubview(c2)
        
        let c1 = shadowAndCorner(1)
        c1.top = c2.botttomWithOffset(10)
        view.addSubview(c1)

    }
    
    func shadowAndCorner (corner: CGFloat) -> UIView {
        
        let topView = UIView (x: 10, y: StatusBarHeight + 10, w: ScreenWidth-20, h: 100)
        topView.addShadow(
            CGSize (width: 0, height: 1),
            radius: 1,
            color: UIColor.TitleColor(),
            opacity: 1,
            cornerRadius: corner)
        
        let otherView = UIView (frame: topView.frame)
        otherView.position = CGPointZero
        otherView.backgroundColor = UIColor.CardHeaderColor()
        otherView.setCornerRadius(corner)
        topView.addSubview(otherView)
        
        let label = UILabel (
            frame: otherView.frame,
            text: "corner radius \(corner)",
            textColor: UIColor.TitleColor(),
            textAlignment: .Center,
            font: UIFont.AvenirNext(.Regular, size: 20))
        otherView.addSubview(label)
        
        return topView
    }
    
    func materialDemo () {
        let c = MaterialCardView (x: 10, y: StatusBarHeight + 10, w: ScreenWidth-20)
        view.addSubview(c)
        
        c.addHeader("Header")
        c.addCell("Item 1")
        c.addCell("Item 2")
        c.addCell("Item 3")
        
        let container = UIView (x: 0, y: 0, w: c.w, h: 0)
        
        let label = UILabel (
            x: 10,
            y: 0,
            width: c.w - 10,
            padding: 10,
            attributedText: NSAttributedString.withAttributedStrings({ (att: NSMutableAttributedString) -> () in
                att.appendAttributedString(NSAttributedString (
                    text: "Att ",
                    color: UIColor.brownColor(),
                    font: UIFont.AvenirNextRegular(15),
                    style: .plain))
                att.appendAttributedString(NSAttributedString (
                    text: "\nTest",
                    color: UIColor.blueColor(),
                    font: UIFont.AvenirNextDemiBold(15),
                    style: .plain))
                att.appendAttributedString(NSAttributedString (
                    text: "\npowered by CEMKit",
                    color: UIColor.redColor(),
                    font: UIFont.AvenirNextRegular(13),
                    style: .underline(NSUnderlineStyle.StyleSingle, UIColor.blackColor())))
            }),
            textAlignment: .Center)
        
        container.addSubview(label)
        container.h = label.h
        container.addRipple(
            UIColor.Gray(51, alpha: 0.2),
            duration: 0.5,
            location: .TouchLocation,
            action: {
                println("act")
        })
        
        c.addFooter(container)
    }
}

