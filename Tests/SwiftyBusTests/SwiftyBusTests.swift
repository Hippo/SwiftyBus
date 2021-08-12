import XCTest
@testable import SwiftyBus

final class SwiftyBusTests: XCTestCase {

  final class TestEvent: Event {
    let value: Int

    init(value: Int) {
      self.value = value
    }
  }

  class MyEvent: Event {}


  func testBasic() {
    let bus = SwiftyBus()

    bus.post(MyEvent())

    let listener = bus.listen(TestEvent.self) { testEvent in
      print(testEvent.value)
    }

    bus.post(TestEvent(value: 420))
    bus.unregister(listener)
    bus.post(TestEvent(value: 69))
  }

  func testAsync() {
    let bus = SwiftyBus()

    bus.async(TestEvent.self) { testEvent in
      print("Async \(testEvent.value)")
    }
    bus.listen(TestEvent.self) { testEvent in
      print("Sync \(testEvent.value)")
    }

    for i in 1...5 {
      bus.post(TestEvent(value: i))
    }
  }
}
