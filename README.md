# SwiftyBus

A simple eventbus written in Swift.

# Getting started
To add `SwiftyBus` as a dependency do the following

Declare the dependency in your `Package.swift`
```swift
.package(url: "https://github.com/Hippo/SwiftyBus.git", from: "1.0.2")
```

Then you will need to add it to your target as such
```swift
.product(name: "SwiftyBus", package: "SwiftyBus")
```

# Import the library
```swift
import SwiftyBus
```

# Making an event

```swift
final class MyEvent: Event {
  let myString: String

  init(myString: String) {
    self.myString = myString
  }
}
```

# Registering a listener

```swift
let bus = SwiftyBus()

// optionally store the listener
let listener = bus.listen(MyEvent.self) { myEvent in
  print(myEvent.myString)
}

// For async listeners
bus.async(MyEvent.self) { myEvent in
  print(myEvent.myString)
}
```

# Posting an event

```swift
bus.post(MyEvent(myString: "Posting event"))
```

# Unregistering a listener

```swift
bus.unregister(listener)
```
