import CoreGraphics

public enum Device: CustomStringConvertible, Equatable {
  case iPhone(IPhoneModel)
  case iPad(IPadModel)
  case iPod(IPodModel)
  case appleTV(AppleTVModel)
  case watch
  case mac
  case unknown(identifier: String)
  
  static let current = Device.determine()
  
  public var description: String {
    switch self {
    case .iPhone(let model): return "iPhone \(model.description)"
    case .iPad(let model): return "iPad \(model.description)"
    case .iPod(let model): return "iPod Touch \(model.description)"
    case .appleTV(let model): return "AppleTV \(model.description)"
    case .watch: return "Watch"
    case .mac: return "Mac"
    case .unknown(let identifier): return "Unkown Device (\(identifier))"
    }
  }
  
  public var supportsTrueBlack: Bool {
    switch self {
    case .iPhone(let model):
      return [.x, .xs, .xsMax, ._11Pro, ._11ProMax, ._11, ._12mini, ._12, ._12Pro, ._12ProMax].contains(model)
    case .watch:
      return true
    default: return false
    }
  }
  
  public var supportsCellularConnections: Bool {
    switch self {
    case .iPhone: return true
    default: return false
    }
  }
  
  public var hasSmallScreen: Bool {
    switch self {
    case .iPhone(let model):
      return [.se1].contains(model)
    case .iPod(let model):
      return [.iPod7].contains(model)
    default: return false
    }
  }
  
  public var appIconSize: CGFloat {
    60
//    switch self {
//    case .iPhone(_), .iPod(_):
//      return 60
//    case .iPad(let model):
//      if [.pro12Inch1, .pro12Inch2, .pro12Inch3, .pro12Inch4].contains(model) {
//        return 83.5
//      } else {
//        return 76
//      }
//    default: return 60
//    }
  }
  
  public var tryBottomHeavy: Bool {
    switch self {
    case .iPhone(_), .iPod(_):
      return true
    default: return false
    }
  }
  
  public var isSlow: Bool {
    switch self {
    case .iPhone(let model):
      return [.se1, ._6s, ._6sPlus, ._7, ._7Plus].contains(model)
    case .iPod:
      return true
    default: return false
    }
  }
  
  public var hasHomeButton: Bool {
    screenCornerRadius == 0
  }
  
  public var screenCornerRadius: CGFloat {
    switch self {
    case .iPhone(.x), .iPhone(.xs), .iPhone(.xsMax), .iPhone(._11Pro), .iPhone(._11ProMax): return 39
    case .iPhone(._11), .iPhone(.xr): return 41.5
    case .iPhone(._12mini): return 44
    case .iPhone(._12), .iPhone(._12Pro): return 47
    case .iPhone(._12ProMax): return 53
    case .iPad(.air4), .iPad(.pro11Inch1), .iPad(.pro11Inch2), .iPad(.pro12Inch3), .iPad(.pro12Inch4): return 18
    default: return 0
    }
  }
  
  public var iconName: String {
    switch self {
    case .iPhone:
      return screenCornerRadius > 0 ? "iphone" : "iphone.homebutton"
    case .iPad:
      return screenCornerRadius > 0 ? "ipad" : "ipad.homebutton"
    case .iPod: return "ipodtouch"
    case .watch: return "applewatch"
    case .appleTV: return "appletv"
    case .mac: return "laptopcomputer"
    case .unknown: return "airplayaudio"
    }
  }
  
  static var deviceModelIdentifier: String {
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    let identifier = machineMirror.children.reduce("") { identifier, element in
      guard let value = element.value as? Int8, value != 0 else { return identifier }
      return identifier + String(UnicodeScalar(UInt8(value)))
    }
    return identifier
  }
  
  static func determine() -> Device {
    let id = deviceModelIdentifier
    
    if id.hasPrefix(IPhoneModel.identifierPrefix) {
      return .iPhone(.inferFrom(modelNumber: id))
    } else if id.hasPrefix(IPadModel.identifierPrefix) {
      return .iPad(.inferFrom(modelNumber: id))
    } else if id.hasPrefix(IPodModel.identifierPrefix) {
      return .iPod(.inferFrom(modelNumber: id))
    } else if id.hasPrefix(AppleTVModel.identifierPrefix) {
      return .appleTV(.inferFrom(modelNumber: id))
    } else if id.hasPrefix("x64_86") {
      return .mac
    } else {
      return .unknown(identifier: id)
    }
  }
}
