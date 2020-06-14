# SwiftMinions

![latest version](https://img.shields.io/cocoapods/v/SwiftMinions)![license](https://img.shields.io/github/license/SwiftMinions/SwiftMinions)![platform](https://img.shields.io/cocoapods/p/SwiftMinions)

This project is a collection of offen used swift functions, the purpose is to save your day.

There are lots of frameworks that better than us. 

Instead of creating products without reasons and purpose, we choose to build our own Framework from a clear starting point.

We inspire from SwifterSwift and strict follow naming conventions

## Request

-   iOS 10.0+
-   Swift 5.0+

## Install

OhSwifter available through [Cocoapods](http://cocoapods.org), simply add the following line to your Podfile:

```
pod 'SwiftMinions'
```

## What different with SwifterSwift?

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