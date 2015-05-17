# SMDatePicker

Customisable UIDatePicker with UIToolbar. Easy to setup, use and customize. Take a look at preview:

![Preview](https://raw.githubusercontent.com/anatoliyv/SMDatePicker/master/Main/SMDatePicker.gif)

### Installation

This repo has example project, but if you want to include SMDatePicker you need only one file **SMDatePicker.swift**. Alternatively you can use CocoaPods to install:

```
pod 'SMDatePicker'
```

### Usage

Usage is as simple as possible. Here is an swift example:

```
// Initialize
var picker: SMDatePicker = SMDatePicker()

// Set delegate
picker.delegate = self
```

You have SMDatePickerDelegate protocol to handle picker's events. Here are list:

```
datePickerWillAppear(picker: SMDatePicker)
datePickerDidAppear(picker: SMDatePicker)
    
datePicker(picker: SMDatePicker, didPickDate date: NSDate)
datePickerDidCancel(picker: SMDatePicker)
    
datePickerWillDisappear(picker: SMDatePicker)
datePickerDidDisappear(picker: SMDatePicker)
```

Now you can customize picker to support your design:

```
// Customize background colors
picker.toolbarBackgroundColor = UIColor.grayColor()
picker.pickerBackgroundColor = UIColor.lightGrayColor()

// Customize title
picker.title = "Cool title"
picker.titleFont = UIFont.systemFontOfSize(16)
picker.titleColor = UIColor.whiteColor()

// Customize toolbar buttons
var buttonOne = toolbarButton("One")
var buttonTwo = toolbarButton("Two")
var buttonThree = toolbarButton("Three")
        
picker.leftButtons = [ UIBarButtonItem(customView: buttonOne) ]
picker.rightButtons = [ UIBarButtonItem(customView: buttonTwo) , UIBarButtonItem(customView: buttonThree) ]
```

Where toolbarButton(...) is a method:

```
private func toolbarButton(title: String) -> UIButton {
    var button = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    button.setTitle(title, forState: UIControlState.Normal)
    button.frame = CGRectMake(0, 0, 70, 32)
    button.backgroundColor = UIColor.redColor().colorWithAlphaComponent(0.4)
    button.layer.cornerRadius = 5.0
        
    return button
}
```

And finaly show picker in your view:

```
picker.showPickerInView(view, animated: true)
```

### License

The MIT License (MIT)

Copyright (c) 2015 Anatoliy

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
