# JKSteppedProgressBar

[![CI Status](https://travis-ci.org/jkmathew/JKSteppedProgressBar.svg?branch=master&style=flat)](https://travis-ci.org/jkmathew/JKSteppedProgressBar)
[![Version](https://img.shields.io/cocoapods/v/JKSteppedProgressBar.svg?style=flat)](http://cocoapods.org/pods/JKSteppedProgressBar)
[![codebeat badge](https://codebeat.co/badges/bd080c48-5f50-42b3-9ff6-5cef2b192ad5)](https://codebeat.co/projects/github-com-johnykutty-jksteppedprogressbar)
[![Platform](https://img.shields.io/cocoapods/p/JKSteppedProgressBar.svg?style=flat)](http://cocoapods.org/pods/JKSteppedProgressBar)
[![License](https://img.shields.io/cocoapods/l/JKSteppedProgressBar.svg?style=flat)](http://cocoapods.org/pods/JKSteppedProgressBar)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
To use JKSteppedProgressBar Xcode 8.0 or later is required

## Installation
JKSteppedProgressBar is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:
```ruby
pod 'JKSteppedProgressBar'
```
JKSteppedProgressBar can be added and configured directly from storyboard. 

## How to Add Stepped Progress Bar
- Add a blank UIView and set constraints
- Set the Class & Module from identity inspector
- Set the active & inactive color from Attributes inspector

### setting custom title
- Use the IBOutlet instance to set properties
- Set your title array to _titles_ property
```
  progressbar.titles = ["Step 1", "Step 2", "Step 3"]
```
### setting custom title and images
- Use the IBOutlet instance to set properties
- Set your title array to _titles_ property
- Set your images array to _images_ property
```
  progressbar.titles = ["Step 1", "Step 2", "Step 3"]
  progressbar.images = [
    UIImage(named: "DaisyDuck")!,
    UIImage(named: "MickeyMouse")!,
    UIImage(named: "MinnieMouse")!,
  ]
```


## Demo
[![Demo Video](http://img.youtube.com/vi/gKFrOL7nD6I/0.jpg)](http://www.youtube.com/watch?v=gKFrOL7nD6I)



## TODO
- [x] Add image for steps
- [ ] Respect language direction for drawing

## Author

Johnykutty, johnykutty.mathew@gmail.com

## License

JKSteppedProgressBar is available under the MIT license. See the LICENSE file for more info.

