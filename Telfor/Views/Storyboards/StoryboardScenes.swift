// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import UIKit

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Storyboard Scenes

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
internal enum StoryboardScene {
  internal enum Author: StoryboardType {
    internal static let storyboardName = "Author"

    internal static let initialScene = InitialSceneType<AuthorDetailsViewController>(storyboard: Author.self)

    internal static let authorDetailsViewController = SceneType<AuthorDetailsViewController>(storyboard: Author.self, identifier: "AuthorDetailsViewController")
  }
  internal enum LaunchScreen: StoryboardType {
    internal static let storyboardName = "LaunchScreen"

    internal static let initialScene = InitialSceneType<UIKit.UIViewController>(storyboard: LaunchScreen.self)
  }
  internal enum Main: StoryboardType {
    internal static let storyboardName = "Main"

    internal static let initialScene = InitialSceneType<TabBarViewController>(storyboard: Main.self)
  }
  internal enum Paper: StoryboardType {
    internal static let storyboardName = "Paper"

    internal static let initialScene = InitialSceneType<PaperDetailsViewController>(storyboard: Paper.self)

    internal static let paperDetailsViewController = SceneType<PaperDetailsViewController>(storyboard: Paper.self, identifier: "PaperDetailsViewController")
  }
  internal enum Room: StoryboardType {
    internal static let storyboardName = "Room"

    internal static let initialScene = InitialSceneType<RoomDetailsViewController>(storyboard: Room.self)

    internal static let roomDetailsViewController = SceneType<RoomDetailsViewController>(storyboard: Room.self, identifier: "RoomDetailsViewController")
  }
  internal enum Session: StoryboardType {
    internal static let storyboardName = "Session"

    internal static let initialScene = InitialSceneType<SessionDetailsViewController>(storyboard: Session.self)

    internal static let sessionDetailsViewController = SceneType<SessionDetailsViewController>(storyboard: Session.self, identifier: "SessionDetailsViewController")
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

// MARK: - Implementation Details

internal protocol StoryboardType {
  static var storyboardName: String { get }
}

internal extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = self.storyboardName
    return UIStoryboard(name: name, bundle: Bundle(for: BundleToken.self))
  }
}

internal struct SceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type
  internal let identifier: String

  internal func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
    }
    return controller
  }
}

internal struct InitialSceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type

  internal func instantiate() -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
      fatalError("ViewController is not of the expected class \(T.self).")
    }
    return controller
  }
}

private final class BundleToken {}
