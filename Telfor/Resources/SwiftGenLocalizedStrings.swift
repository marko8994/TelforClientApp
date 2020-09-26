// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum LocalizedStrings {

  internal enum Common {
    /// Authors
    internal static let authors = LocalizedStrings.tr("Localizable", "Common.Authors")
    /// Papers
    internal static let papers = LocalizedStrings.tr("Localizable", "Common.Papers")
    /// Rooms
    internal static let rooms = LocalizedStrings.tr("Localizable", "Common.Rooms")
    /// View all
    internal static let viewAll = LocalizedStrings.tr("Localizable", "Common.ViewAll")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension LocalizedStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}