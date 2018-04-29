# JKSteppedProgressBar

[![CI Status](https://travis-ci.org/jkmathew/JKSteppedProgressBar.svg?branch=master&style=flat)](https://travis-ci.org/jkmathew/JKSteppedProgressBar)
[![Version](https://img.shields.io/cocoapods/v/JKSteppedProgressBar.svg?style=flat)](http://cocoapods.org/pods/JKSteppedProgressBar)
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
### setting custom color for the progress
- after setting your titles or images, set the property **activeStepColors**
```
progressbar.activeStepColors = [
  UIColor.red,
  UIColor.orange,
  UIColor.green,
]
```
- this will change the color whenever you are at that step. For example, when you are at step 1, it will be red. And in second step, the whole progress bar will become orange and when you are at the last step, it will be green. So that the user will get a feeling of accomplishment through the steps.
-
### setting custom active-images
- this will make it possible to use this as progress for forms
- Set your images to *activeImages* property
- Set your tintActiveImage to tint the images to the active color (default: false)
- Set your justCheckCompleted to select everything behind the current step but keep the current step highlighted (default: true)

```
  progressbar.activeImages = [
      UIImage(named: "check")!,
      UIImage(named: "check")!,
      UIImage(named: "check")!,
  ]
  progressbar.tintActiveImage = true
  progressbar.justCheckCompleted = false
```

## Demo
[![Demo Video](http://img.youtube.com/vi/gKFrOL7nD6I/0.jpg)](http://www.youtube.com/watch?v=gKFrOL7nD6I)



## TODO
- [x] Add image for steps
- [x] Respect language direction for drawing

## Author

- Johnykutty, johnykutty.mathew@gmail.com
- Jayahari V, jayahariv88@gmail.com
- And [others](https://github.com/jkmathew/JKSteppedProgressBar/graphs/contributors)

## License

JKSteppedProgressBar is available under the MIT license. See the LICENSE file for more info.

