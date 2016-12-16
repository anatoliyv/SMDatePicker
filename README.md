[![CI Status](http://img.shields.io/travis/anatoliyv/SMDatePicker.svg?style=flat)](https://travis-ci.org/anatoliyv/SMDatePicker)
[![Version](https://img.shields.io/cocoapods/v/SMDatePicker.svg?style=flat)](http://cocoapods.org/pods/SMDatePicker)
[![License](https://img.shields.io/cocoapods/l/SMDatePicker.svg?style=flat)](http://cocoapods.org/pods/SMDatePicker)
[![Platform](https://img.shields.io/cocoapods/p/SMDatePicker.svg?style=flat)](http://cocoapods.org/pods/SMDatePicker)
![](https://img.shields.io/badge/Supported-iOS9-4BC51D.svg?style=flat)
![](https://img.shields.io/badge/Swift 3-compatible-4BC51D.svg?style=flat)

# SMDatePicker

Customizable UIDatePicker with UIToolbar. Easy to setup, use and customize. Take a look at preview:

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

## Author

- anatoliy.voropay@gmail.com
- [@anatoliy_v](https://twitter.com/anatoliy_v)
- [LinkedIn](https://www.linkedin.com/in/anatoliyvoropay)

## License

SMDatePicker is available under the MIT license. See the LICENSE file for more info.
