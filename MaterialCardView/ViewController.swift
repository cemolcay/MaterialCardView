//
//  ViewController.swift
//  MaterialCardView
//
//  Created by Cem Olcay on 22/01/15.
//  Copyright (c) 2015 Cem Olcay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        materialDemo()
    }

    func materialDemo () {
        
        let scroll = UIScrollView (frame: view.frame)
        view.addSubview(scroll)
        
        let c = MaterialCardView (
            x: 10,
            y: StatusBarHeight + 10,
            w: ScreenWidth-20)
        scroll.addSubview(c)
        
        c.addHeader("Header")
        c.addCell("Item 1")
        c.addCell("Item 2")
        c.addCell("Item 3")
        addFooter(c)
        
        let cc = MaterialCardView (x: 10, y: c.botttomWithOffset(10), w: c.w)
        scroll.addSubview(cc)
        
        cc.addHeader("Header")
        cc.addCell("Item 1")
        cc.addCell("Item 2")
        cc.addCell("Item 3")
        
        scroll.contentHeight = cc.botttomWithOffset(10)
    }
    
    func addFooter (c: MaterialCardView) {
        let container = UIView (x: 0, y: 0, w: c.w, h: 0)
        
        let label = UILabel (
            x: 10,
            y: 0,
            width: c.w - 10,
            padding: 10,
            attributedText: NSAttributedString.withAttributedStrings({ (att: NSMutableAttributedString) -> () in
                att.appendAttributedString(NSAttributedString (
                    text: "Footer Label",
                    color: UIColor.TitleColor(),
                    font: UIFont.TitleFont(),
                    style: .plain))
                att.appendAttributedString(NSAttributedString (
                    text: "\nAttributed String",
                    color: UIColor.TextColor(),
                    font: UIFont.TitleFont(),
                    style: .plain))
                att.appendAttributedString(NSAttributedString (
                    text: "\npowered by CEMKit",
                    color: UIColor.TextColor(),
                    font: UIFont.TextFont(),
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

