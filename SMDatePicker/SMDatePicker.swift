//
//  SMDatePicker.swift
//  Countapp
//
//  Created by Anatoliy Voropay on 5/12/15.
//  Copyright (c) 2015 Smartarium.com. All rights reserved.
//

import UIKit

@objc public protocol SMDatePickerDelegate {
    
    optional func datePickerWillAppear(picker: SMDatePicker)
    optional func datePickerDidAppear(picker: SMDatePicker)
    
    optional func datePicker(picker: SMDatePicker, didPickDate date: NSDate)
    optional func datePickerDidCancel(picker: SMDatePicker)
    
    optional func datePickerWillDisappear(picker: SMDatePicker)
    optional func datePickerDidDisappear(picker: SMDatePicker)
    
}

@objc public class SMDatePicker: UIView {
    
    /** Picker's delegate that conforms to SMDatePickerDelegate protocol */
    public var delegate: SMDatePickerDelegate?
    
    /** UIToolbar title */
    public var title: String?
    public var titleFont: UIFont = UIFont.systemFontOfSize(13)
    public var titleColor: UIColor = UIColor.grayColor()
    
    /** You can define your own toolbar height. By default it's 44 pixels. */
    public var toolbarHeight: CGFloat = 44.0
    
    /** Specify different UIDatePicker mode. By default it's UIDatePickerMode.DateAndTime */
    public var pickerMode: UIDatePickerMode = UIDatePickerMode.DateAndTime {
        didSet { picker.datePickerMode = pickerMode }
    }
    
    /** You can set up different color for picker and toolbar. */
    public var toolbarBackgroundColor: UIColor? {
        didSet {
            toolbar.backgroundColor = toolbarBackgroundColor
            toolbar.barTintColor = toolbarBackgroundColor
        }
    }
    
    /** You can set up different color for picker and toolbar. */
    public var pickerBackgroundColor: UIColor? {
        didSet { picker.backgroundColor = pickerBackgroundColor }
    }
    
    /** Initial picker's date */
    public var pickerDate: NSDate = NSDate() {
        didSet { picker.date = pickerDate }
    }
    
    /** Array of UIBarButtonItem's that will be placed on left side of UIToolbar. By default it has only 'Cancel' bytton. */
    public var leftButtons: [UIBarButtonItem] = []
    
    /** Array of UIBarButtonItem's that will be placed on right side of UIToolbar. By default it has only 'Done' bytton. */
    public var rightButtons: [UIBarButtonItem] = []
    
    // Privates
    
    private var toolbar: UIToolbar = UIToolbar()
    private var picker: UIDatePicker = UIDatePicker()
    
    // MARK: Lifecycle
    
    public override init(frame: CGRect) {
        super.init(frame: CGRectZero)
        
        addSubview(picker)
        addSubview(toolbar)
        
        setupDefaultButtons()
        customize()
    }

    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addSubview(picker)
        addSubview(toolbar)
        
        setupDefaultButtons()
        customize()
    }
    
    // MARK: Customization
    
    private func setupDefaultButtons() {
        var doneButton = UIBarButtonItem(title: "Done",
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: Selector("pressedDone:"))

        var cancelButton = UIBarButtonItem(title: "Cancel",
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: Selector("pressedCancel:"))
        
        leftButtons = [ cancelButton ]
        rightButtons = [ doneButton ]
    }
    
    private func customize() {
        toolbar.barStyle = UIBarStyle.BlackTranslucent
        toolbar.translucent = false
        
        backgroundColor = UIColor.whiteColor()
        
        if let toolbarBackgroundColor = toolbarBackgroundColor {
            toolbar.backgroundColor = toolbarBackgroundColor
        } else {
            toolbar.backgroundColor = backgroundColor
        }
        
        if let pickerBackgroundColor = pickerBackgroundColor {
            picker.backgroundColor = pickerBackgroundColor
        } else {
            picker.backgroundColor = backgroundColor
        }
    }
    
    private func toolbarItems() -> [UIBarButtonItem] {
        var items: [UIBarButtonItem] = []
        
        for button in leftButtons {
            items.append(button)
        }
        
        if let title = toolbarTitle() {
            var spaceLeft = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
            var spaceRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
            var titleItem = UIBarButtonItem(customView: title)
            
            items.append(spaceLeft)
            items.append(titleItem)
            items.append(spaceRight)
        } else {
            var space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
            items.append(space)
        }
        
        for button in rightButtons {
            items.append(button)
        }
        
        return items
    }
    
    private func toolbarTitle() -> UILabel? {
        if let title = title {
            var label = UILabel()
            label.text = title
            label.font = titleFont
            label.textColor = titleColor
            label.sizeToFit()
            
            return label
        }
        
        return nil
    }
    
    // MARK: Showing and hiding picker
    
    /**
    Shows picker in view with animation if it's required.
    
    :param: view is a UIView where we want to show our picker
    :param: animated will show with animation if it's true
    
    */
    public func showPickerInView(view: UIView, animated: Bool) {
        toolbar.items = toolbarItems()
        
        toolbar.frame = CGRectMake(0, 0, view.frame.size.width, toolbarHeight)
        picker.frame = CGRectMake(0, toolbarHeight, view.frame.size.width, picker.frame.size.height)
        self.frame = CGRectMake(0, view.frame.size.height - picker.frame.size.height - toolbar.frame.size.height,
            view.frame.size.width, picker.frame.size.height + toolbar.frame.size.height)

        view.addSubview(self)
        becomeFirstResponder()
        
        showPickerAnimation(animated)
    }
    
    /**
    Hide visible picker anikmated. 

    :param: animated will hide with animation if `true`
    */
    public func hidePicker(animated: Bool) {
        hidePickerAnimation(true)
    }
    
    // MARK: Animation
    
    private func hidePickerAnimation(animated: Bool) {
        delegate?.datePickerWillDisappear?(self)
        
        if animated {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.frame = CGRectOffset(self.frame, 0, self.picker.frame.size.height + self.toolbar.frame.size.height)
            }) { (finished) -> Void in
                delegate?.datePickerDidDisappear?(self)
            }
        } else {
            self.frame = CGRectOffset(self.frame, 0, self.picker.frame.size.height + self.toolbar.frame.size.height)
            delegate?.datePickerDidDisappear?(self)
        }
    }
    
    private func showPickerAnimation(animated: Bool) {
        delegate?.datePickerWillAppear?(self)
        
        if animated {
            self.frame = CGRectOffset(self.frame, 0, self.frame.size.height)
            
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.frame = CGRectOffset(self.frame, 0, -1 * self.frame.size.height)
            }) { (finished) -> Void in
                delegate?.datePickerDidAppear?(self)
            }
        } else {
            delegate?.datePickerDidAppear?(self)
        }
    }
    
    // MARK: Actions
    
    /**
    Default Done action for picker. It will hide picker with animation and call's delegate datePicker(:didPickDate) method.
    */
    public func pressedDone(sender: AnyObject) {
        hidePickerAnimation(true)
        
        delegate?.datePicker?(self, didPickDate: picker.date)
    }
    
    /**
    Default Cancel actions for picker.
    */
    public func pressedCancel(sender: AnyObject) {
        hidePickerAnimation(true)
        
        delegate?.datePickerDidCancel?(self)
    }

}
