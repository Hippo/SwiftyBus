import Foundation

final class AsynchronousListener<T: Event>: Listener {

  private let closure: (T) -> Void
  private let id: Int

  init(closure: @escaping (T) -> Void) {
    self.closure = closure
    id = ListenerMeta.watch
    ListenerMeta.watch += 1
  }

  func invoke<S: Event>(event: S) -> Bool {
    guard let actual = event as? T else {
      return false
    }

    ListenerMeta.queue.addOperation { [self] in
      closure(actual)
    }
    return true
  }

  func getType<S: Event>() -> S.Type {
    T.self as! S.Type
  }

  func getId() -> Int {
    id
  }
}

fileprivate struct ListenerMeta {
  static var watch = 0
  static let queue = OperationQueue()
}