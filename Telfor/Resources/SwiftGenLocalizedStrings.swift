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
    /// Author details
    internal static let authorDetails = LocalizedStrings.tr("Localizable", "Common.AuthorDetails")
    /// Authors
    internal static let authors = LocalizedStrings.tr("Localizable", "Common.Authors")
    /// Biography
    internal static let biography = LocalizedStrings.tr("Localizable", "Common.Biography")
    /// Contact
    internal static let contact = LocalizedStrings.tr("Localizable", "Common.Contact")
    /// End date
    internal static let endDate = LocalizedStrings.tr("Localizable", "Common.EndDate")
    /// Info
    internal static let info = LocalizedStrings.tr("Localizable", "Common.Info")
    /// Name
    internal static let name = LocalizedStrings.tr("Localizable", "Common.Name")
    /// Organization
    internal static let organization = LocalizedStrings.tr("Localizable", "Common.Organization")
    /// Paper details
    internal static let paperDetails = LocalizedStrings.tr("Localizable", "Common.PaperDetails")
    /// Papers
    internal static let papers = LocalizedStrings.tr("Localizable", "Common.Papers")
    /// Paper type
    internal static let paperType = LocalizedStrings.tr("Localizable", "Common.PaperType")
    /// Position
    internal static let position = LocalizedStrings.tr("Localizable", "Common.Position")
    /// PresentationDate
    internal static let presentationDate = LocalizedStrings.tr("Localizable", "Common.PresentationDate")
    /// QuestionForm
    internal static let questionsForm = LocalizedStrings.tr("Localizable", "Common.QuestionsForm")
    /// Regular paper
    internal static let regularPaper = LocalizedStrings.tr("Localizable", "Common.RegularPaper")
    /// Room
    internal static let room = LocalizedStrings.tr("Localizable", "Common.Room")
    /// Room details
    internal static let roomDetails = LocalizedStrings.tr("Localizable", "Common.RoomDetails")
    /// Rooms
    internal static let rooms = LocalizedStrings.tr("Localizable", "Common.Rooms")
    /// Special paper
    internal static let specialPaper = LocalizedStrings.tr("Localizable", "Common.SpecialPaper")
    /// Start date
    internal static let startDate = LocalizedStrings.tr("Localizable", "Common.StartDate")
    /// Students paper
    internal static let studentsPaper = LocalizedStrings.tr("Localizable", "Common.StudentsPaper")
    /// Summary
    internal static let summary = LocalizedStrings.tr("Localizable", "Common.Summary")
    /// Survey
    internal static let survey = LocalizedStrings.tr("Localizable", "Common.Survey")
    /// Title
    internal static let title = LocalizedStrings.tr("Localizable", "Common.Title")
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
