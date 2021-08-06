import Foundation

public enum AppleTVModel: CustomStringConvertible, Equatable {

  static let identifierPrefix: String = "AppleTV"

  case tv
  case tv4K
  case unknown(modelNumber: String)

  public var description: String {
    switch self {
    case .tv: return "4"
    case .tv4K: return "4k"
    case .unknown(let modelNumber): return "? (\(modelNumber))"
    }
  }

  public static func inferFrom(modelNumber: String) -> AppleTVModel {
    switch modelNumber.replacingOccurrences(of: AppleTVModel.identifierPrefix, with: "") {
    case "5,3": return .tv
    case "6,2": return .tv4K
    default: return .unknown(modelNumber: modelNumber)
    }
  }
}
