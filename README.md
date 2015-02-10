MaterialCardView
================
Create [material design](http://www.google.com/design/spec/material-design/introduction.html) cards quick and easy

Demo
----

![alt tag](https://raw.githubusercontent.com/cemolcay/MaterialCardView/master/ss.png)

Installation
------------

### Manuel

Copy & paste `MaterialCardView.swift` and `CEMKit.swift` to your project

### Cocoapods

Add to your `podfile`

``` ruby
	pod 'MaterialCardView', '~> 0.0.2'
```


Usage
-----

Create a `MaterialCardView`

``` swift
	let c = MaterialCardView (
			       x: 10,
			       y: StatusBarHeight + 10,
			       w: ScreenWidth-20)  
	view.addSubview (c)
```

And start to add `MaterialCardCell`s

* Header Cell

``` swift
	func addHeader (title: String)
	func addHeader (view: UIView)
```

* Cell

``` swift
	addCell (text: String, action: (()->Void)? = nil)
	addCell (view: UIView, action: (()->Void)? = nil)
	addCell (cell: MaterialCardCell)
```

* FooterCell

``` swift
	func addFooter (title: String)
	func addFooter (view: UIView)
```
  
   
>Material Card will update its frame size when you add or 
>remove `MaterialCardCell`s.  
>This is why you don't set its `height` value when initilize it.

MaterialCardAppeareance
-----------

``` swift
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
```

You can change `MaterialCardView` appeareance by its `appeareance` property.

The default appeareance is

``` swift
    func defaultAppeareance () -> MaterialCardAppeareance {
        return MaterialCardAppeareance (
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
```

Which are `UIColor` and `UIFont` extensions defined at top of `MaterialCardView.swift` file.


MaterialAnimationTimingFunction
-------------------------------

``` swift
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

```

#### SwiftEnterInOut

	(0.4027, 0, 0.1, 1)
	
#### SwiftExitInOut
	
	(0.4027, 0, 0.2256, 1)
	

MaterialRippleLocation
----------------------

    enum MaterialRippleLocation {
        case Center
        case TouchLocation
    }


RippleLayer
-----------

##### Adds ripple animation when you add cells with action

``` swift
	c.addCell("Item 1") { sender in 
		println("item 1 tapped") 
	}
```

![alt tag](https://raw.githubusercontent.com/cemolcay/MaterialCardView/master/ripple.gif)


##### Add ripple to material card

``` swift
     c.addRipple { () -> Void in
       println("all card ripples")
   }
```

![alt tag](https://raw.githubusercontent.com/cemolcay/MaterialCardView/master/shadow.gif)



