public protocol Listener {
  func invoke<T: Event>(event: T) -> Bool
  func getType<T: Event>() -> T.Type
  func getId() -> Int
}