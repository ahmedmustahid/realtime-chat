// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "a85f351912a0714aed9a85dc01a871e7"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: Message.self)
  }
}