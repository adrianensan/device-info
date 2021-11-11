import Foundation

public enum AppInfo {
  public static let bundleID: String = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String ?? "?"
  public static let version: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
  public static let build: String = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "?"
  public static let name: String = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "?"
  
  public static let isTestBuild = Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"
  
  public static var rootBundleID: String {
    guard bundleID.hasSuffix(".widget") else { return bundleID }
    return String(bundleID.dropLast(".widget".count))
  }
  public static var appGroup: String { "group.\(rootBundleID)" }
  public static var iCloudContainer: String { "iCloud.\(rootBundleID)" }
}
