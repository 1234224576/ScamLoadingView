# ScamLoadingView

[![Version](https://img.shields.io/cocoapods/v/ScamLoadingView.svg?style=flat)](http://cocoapods.org/pods/ScamLoadingView)
[![License](https://img.shields.io/cocoapods/l/ScamLoadingView.svg?style=flat)](http://cocoapods.org/pods/ScamLoadingView)
[![Platform](https://img.shields.io/cocoapods/p/ScamLoadingView.svg?style=flat)](http://cocoapods.org/pods/ScamLoadingView)


This library can do two things.

- Displaying a long loading screen despite the processing that ends early.
- It takes a long time, but it looks as if loading is going at a fast speed.

## Usage

```swift
let scam = ScamLoadingView(title: "loading...", limitValue: 0.8, arrivalTime: 10.0)

//Show loading View
self.present(scam.loadingViewController, animated: true, completion: nil)

DispatchQueue.global(qos: .default).async {
    //Some processing
    Thread.sleep(forTimeInterval: 3.0)
    
    DispatchQueue.main.async {
    	//Call after you finish processing
        scam.complete {
            scam.loadingViewController.dismiss(animated: true, completion: nil)
        }
    }
}

```        
In this example, regardless of the content of the process, the loading will advance to 80% in 10 seconds.


## Requirements
Swift 3.0+

iOS 10.0+

## Installation

ScamLoadingView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod "ScamLoadingView"
```  

## Author

[Shuhei Sowa], [sowashuhei@gmail.com]

## License

ScamLoadingView is available under the MIT license. See the LICENSE file for more info.