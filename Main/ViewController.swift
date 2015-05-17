//
//  ViewController.swift
//  SMDatePicker
//
//  Created by Anatoliy Voropay on 5/16/15.
//  Copyright (c) 2015 Smartarium.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SMDatePickerDelegate {
    
    private var yPosition: CGFloat = 50.0
    private var activePicker: SMDatePicker?
    
    private var picker: SMDatePicker = SMDatePicker()
    private var button: UIButton = ViewController.cusomButton("Default picker")
    
    private var pickerColor: SMDatePicker = SMDatePicker()
    private var buttonColor: UIButton = ViewController.cusomButton("Custom colors")
    
    private var pickerToolbar: SMDatePicker = SMDatePicker()
    private var buttonToolbar: UIButton = ViewController.cusomButton("Toolbar customization")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.purpleColor().colorWithAlphaComponent(0.8)
        
        button.addTarget(self, action: Selector("button:"), forControlEvents: UIControlEvents.TouchUpInside)
        addButton(button)
        
        buttonColor.addTarget(self, action: Selector("buttonColor:"), forControlEvents: UIControlEvents.TouchUpInside)
        addButton(buttonColor)
        
        buttonToolbar.addTarget(self, action: Selector("buttonToolbar:"), forControlEvents: UIControlEvents.TouchUpInside)
        addButton(buttonToolbar)
    }
    
    private func addButton(button: UIButton) {
        button.sizeToFit()
        button.frame.size = CGSizeMake(self.view.frame.size.width * 0.8, button.frame.height)
        
        var xPosition = (view.frame.size.width - button.frame.width) / 2
        button.frame.origin = CGPointMake(xPosition, yPosition)
        
        view.addSubview(button)
        
        yPosition += button.frame.height * 1.3
    }
    
    class func cusomButton(title: String) -> UIButton {
        var button = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        button.setTitle(title, forState: UIControlState.Normal)
        button.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
        button.layer.cornerRadius = 10
        
        return button
    }
    
    // MARK: Actions

    func button(sender: UIButton) {
        activePicker?.hidePicker(true)
        picker.showPickerInView(view, animated: true)
        picker.delegate = self
        
        activePicker = picker
    }
    
    func buttonColor(sender: UIButton) {
        activePicker?.hidePicker(true)
        
        pickerColor.toolbarBackgroundColor = UIColor.grayColor()
        pickerColor.pickerBackgroundColor = UIColor.lightGrayColor()
        pickerColor.showPickerInView(view, animated: true)
        pickerColor.delegate = self
        
        activePicker = pickerColor
    }
    
    func buttonToolbar(sender: UIButton) {
        activePicker?.hidePicker(true)
        
        pickerToolbar.toolbarBackgroundColor = UIColor.grayColor()
        pickerToolbar.title = "Customized"
        pickerToolbar.titleFont = UIFont.systemFontOfSize(16)
        pickerToolbar.titleColor = UIColor.whiteColor()
        pickerToolbar.delegate = self
        
        var buttonOne = toolbarButton("One")
        var buttonTwo = toolbarButton("Two")
        var buttonThree = toolbarButton("Three")
        
        pickerToolbar.leftButtons = [ UIBarButtonItem(customView: buttonOne) ]
        pickerToolbar.rightButtons = [ UIBarButtonItem(customView: buttonTwo) , UIBarButtonItem(customView: buttonThree) ]
        
        pickerToolbar.showPickerInView(view, animated: true)
        
        activePicker = pickerToolbar
    }
    
    private func toolbarButton(title: String) -> UIButton {
        var button = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        button.setTitle(title, forState: UIControlState.Normal)
        button.frame = CGRectMake(0, 0, 70, 32)
        button.backgroundColor = UIColor.redColor().colorWithAlphaComponent(0.4)
        button.layer.cornerRadius = 5.0
        
        return button
    }
    
    // MARK: SMDatePickerDelegate
    
    func datePicker(picker: SMDatePicker, didPickDate date: NSDate) {
        if picker == self.picker {
            button.setTitle(date.description, forState: UIControlState.Normal)
        } else if picker == self.pickerColor {
            buttonColor.setTitle(date.description, forState: UIControlState.Normal)
        } else if picker == self.pickerToolbar {
            buttonToolbar.setTitle(date.description, forState: UIControlState.Normal)
        }
    }
    
    func datePickerDidCancel(picker: SMDatePicker) {
        if picker == self.picker {
            button.setTitle("Default picker", forState: UIControlState.Normal)
        } else if picker == self.pickerColor {
            buttonColor.setTitle("Custom colors", forState: UIControlState.Normal)
        } else if picker == self.pickerToolbar {
            buttonToolbar.setTitle("Toolbar customization", forState: UIControlState.Normal)
        }
    }

}

