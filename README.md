# SwiftyBus

A simple eventbus written in Swift.


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
