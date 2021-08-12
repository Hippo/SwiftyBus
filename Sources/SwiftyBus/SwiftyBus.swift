public final class SwiftyBus {

  private var listenerMap = [Int: [Listener]]()
  private var registeredEvents = [Event.Type]()

  public init() {}

  /**
   Registers a synchronous listener to the eventbus.
   - Parameters:
     - event: The event type to listen for.
     - closure: The closure that will be invoked when the event is posted.
   - Returns: The listener that is registered.
   */
  @discardableResult
  public func listen<T: Event>(_ event: T.Type, _ closure: @escaping (T) -> Void) -> Listener {
    let listener = SynchronousListener<T>(closure: closure)
    let index = getEventRegistrationIndex(event: event)

    if listenerMap[index] == nil {
      listenerMap[index] = []
    }

    listenerMap[index]?.append(listener)

    return listener
  }

  /**
   Registers an asynchronous listener to the eventbus.
   - Parameters:
     - event: The event to listen for.
     - closure: The closure that will be invoked when the event is posted.
   - Returns: The listener that is registered.
   */
  @discardableResult
  public func async<T: Event>(_ event: T.Type, _ closure: @escaping (T) -> Void) -> Listener {
    let listener = AsynchronousListener<T>(closure: closure)
    let index = getEventRegistrationIndex(event: event)

    if listenerMap[index] == nil {
      listenerMap[index] = []
    }

    listenerMap[index]?.append(listener)

    return listener
  }


  /**
   Posts an event.
   - Parameter event: The event object to post.
   - Returns: Weather all the listeners that were invoked, if any, succeed invocation.
   */
  @discardableResult
  public func post<T: Event>(_ event: T) -> Bool {
    var passes = true
    if let listeners = listenerMap[getEventRegistrationIndex(event: T.self)] {
      for listener in listeners {
        if !listener.invoke(event: event) {
          passes = false
        }
      }
    }
    return passes
  }

  /**
   Unregisters a listener.
   - Parameter listener: The listener to unregister.
   */
  public func unregister(_ listener: Listener) -> Void {
    if let listeners = listenerMap[getEventRegistrationIndex(event: listener.getType())] {
      for (i, subscribed) in listeners.enumerated() {
        if subscribed.getId() == listener.getId() {
          listenerMap[getEventRegistrationIndex(event: listener.getType())]?.remove(at: i)
          break
        }
      }
    }
  }

  private func getEventRegistrationIndex<T: Event>(event: T.Type) -> Int {
    var contains = false
    var index = 0
    for (i, registeredEvent) in registeredEvents.enumerated() {
      if registeredEvent == event {
        contains = true
        index = i
        break
      }
    }
    if !contains {
      index = registeredEvents.count
      registeredEvents.append(event)
    }
    return index
  }
}