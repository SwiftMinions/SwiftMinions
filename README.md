# SwiftMinions

![latest version](https://img.shields.io/cocoapods/v/SwiftMinions?label=version)
![license](https://img.shields.io/github/license/SwiftMinions/SwiftMinions)
![platform](https://img.shields.io/cocoapods/p/SwiftMinions)

This project is a collection of frequent used Swift functions, and the purpose is to save your day.

Instead of creating a product without reasons and purposes, we built our own framework from a clear starting point.

We are inspired by SwifterSwift and strictly follow the naming conventions.

## Requirements

-   iOS 10.0+
-   Swift 5.0+

## Installation

SwiftMinions is available through [Cocoapods](http://cocoapods.org). Just add the following line to your Podfile:

```
pod 'SwiftMinions'
```

## What's the difference with this and SwifterSwift?

You can define the default parameter of the function by yourself.

-   SwifterSwift

    ```swift
    func string(withFormat format: String = "dd/MM/yyyy HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    ```

-   SwiftMinions

    ```swift
    open class SMConfig {
        public static var dateFormatString = "yyyy-MM-dd HH:mm:ss"
        // ...  
    }

    func toString(format: String = SMConfig.dateFormatString) -> String {
        let formatter = SMConfig.dateFormatter
        formatter.dateFormat = format
        formatter.timeZone = SMConfig.timeZone
        return formatter.string(from: self)
    }
    ```

## License

SwiftMinions is released under the MIT license. See LICENSE for details.
