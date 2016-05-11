//
//  BHTextField.swift
//  Boozehound
//
//  Created by MAC-186 on 2/2/16.
//  Copyright © 2016 MoveoApps. All rights reserved.
//

import UIKit

@IBDesignable
class BHTextField: UITextField {

    var btnClear : UIButton!
    var btnRight : UIButton!
    
    // MARK: - Properties
    @IBInspectable var boolShowClearButton : Bool = false {
        didSet {
            btnClear = UIButton(type: UIButtonType.Custom)
            btnClear.setImage(UIImage(named: "clearTextIcon"), forState: UIControlState.Normal)
            btnClear.frame = CGRectMake(0, 0, 40, self.frame.size.height)
            btnClear.addTarget(self, action: #selector(BHTextField.clearText), forControlEvents: UIControlEvents.TouchUpInside)
            btnClear.alpha = 0.0
            rightView = self.btnClear
            rightViewMode = UITextFieldViewMode.WhileEditing;
        }
    }
    
    func clearText() {
        btnClear.alpha = 0.0
        text = ""
    }
    
    @IBInspectable var borderColor : UIColor = UIColor.whiteColor() {
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
    
    @IBInspectable var borderWidth : CGFloat = 1.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius : CGFloat = 1.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            clipsToBounds = true
        }
    }
    
    @IBInspectable var placeHolderColor : UIColor = UIColor.whiteColor() {
        didSet {
            if ((placeholder) != nil) {
                attributedPlaceholder = NSAttributedString(string: placeholder!, attributes:[NSForegroundColorAttributeName: placeHolderColor])
            }
        }
    }
    
    @IBInspectable var leftViewImage : UIImage = UIImage() {
        didSet {
            let aView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: frame.size.height))
            let aImgView : UIImageView = UIImageView(image: leftViewImage)
            aImgView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            aImgView.center = CGPointMake(aView.center.x, aView.center.y)
            aImgView.contentMode = UIViewContentMode.ScaleAspectFit
            aView.addSubview(aImgView)
            leftViewMode = UITextFieldViewMode.Always
            leftView = aView
        }
    }
    
    @IBInspectable var rightViewImage : UIImage = UIImage() {
        didSet {
            btnRight = UIButton(type: UIButtonType.Custom)
            btnRight.setImage(rightViewImage, forState: UIControlState.Normal)
            btnRight.frame = CGRectMake(0, 0, 40, self.frame.size.height)
//            
//            let aView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: frame.size.height))
//            let aImgView : UIImageView = UIImageView(image: rightViewImage)
//            aImgView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
//            aImgView.center = CGPointMake(aView.center.x, aView.center.y)
//            aImgView.contentMode = UIViewContentMode.ScaleAspectFit
//            aView.addSubview(aImgView)
            rightViewMode = UITextFieldViewMode.Always
            rightView = btnRight
        }
    }
    
    @IBInspectable var extraEmptyRight : Bool = false {
        didSet {
            addExtraEmptyRight()
        }
    }
    
    @IBInspectable var extraEmptyLeft : Bool = false {
        didSet {
            addExtraEmptyLeft()
        }
    }
    
    // MARK: - Initializers
    
    override init(frame : CGRect) {
        super.init(frame : frame)
        setup()
        configure()
    }
    
    convenience init() {
        self.init(frame:CGRectZero)
        setup()
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        configure()
        addEmptyView() // to add default space both side run time
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        configure()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
        configure()
    }
    
    func setup() {
        layer.borderColor = UIColor.whiteColor().CGColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 1.0
    }
    
    func configure() {
        layer.borderColor = borderColor.CGColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func addEmptyView() {
        let aLeftView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: leftView == nil ? 10 : 40, height: frame.size.height))
        leftViewMode = UITextFieldViewMode.Always
        leftView = aLeftView
        let aRightView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: rightView == nil ? 10 : 40, height: frame.size.height))
        rightViewMode = UITextFieldViewMode.Always
        rightView = aRightView
    }

    func addExtraEmptyLeft() {
        let aLeftView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: frame.size.height))
        leftViewMode = UITextFieldViewMode.Always
        leftView = aLeftView
    }
    
    func addExtraEmptyRight() {
        let aRightView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: frame.size.height))
        rightViewMode = UITextFieldViewMode.Always
        rightView = aRightView
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
