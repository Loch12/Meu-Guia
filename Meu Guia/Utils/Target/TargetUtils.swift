import Foundation
import UIKit

class TargetUtils {
  // MARK: - Shared
  private static let shared = TargetUtils()

  // MARK: - Properties
  private static let targetPlistGeneral = TargetPlistGeneral()
  private static let targetPlistColors = TargetPlistColor()
  private static let targetPlistString = TargetPlistString()
  private var dictionary: NSDictionary

  // MARK: - Inits
  init() {
    if let path = Bundle.main.path(forResource: "Target", ofType: ".plist"),
       let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
      dictionary = dict as NSDictionary
    } else {
      dictionary = NSDictionary()
    }
  }

  // MARK: - Methods
  private static func getBool(_ field: String) -> Bool {
    return getBool(field, empty: false)
  }

  private static func getBool(_ field: String, empty: Bool) -> Bool {
    if let bool = shared.dictionary[field] as? Bool {
      return bool
    }
    return empty
  }

  private static func getString(_ field: String) -> String {
    return getString(field, empty: "")
  }

  private static func getString(_ field: String, empty: String) -> String {
    if let str = shared.dictionary[field] as? String {
      return str
    }
    return empty
  }

  private static func getInt(_ field: String) -> Int {
    return getInt(field, empty: 0)
  }

  private static func getInt(_ field: String, empty: Int) -> Int {
    if let numInt = shared.dictionary[field] as? Int {
      return numInt
    }
    return empty
  }

  private static func getFloat(_ field: String) -> Float {
    return getFloat(field, empty: 0)
  }

  private static func getFloat(_ field: String, empty: Float) -> Float {
    if let numFloat = shared.dictionary[field] as? Float {
      return numFloat
    }
    return empty
  }

  private static func getDouble(_ field: String) -> Double {
    return getDouble(field, empty: 0)
  }

  private static func getDouble(_ field: String, empty: Double) -> Double {
    if let numDouble = shared.dictionary[field] as? Double {
      return numDouble
    }
    return empty
  }

  private static func getDictionary(_ field: String) -> NSDictionary {
    return getDictionary(field, empty: NSDictionary())
  }

  private static func getDictionary(_ field: String, empty: NSDictionary) -> NSDictionary {
    if let dict = shared.dictionary[field] as? NSDictionary {
      return dict
    }
    return empty
  }

  private static func getArrayOfDictionary(_ field: String) -> [[String: Any]] {
    return getArrayOfDictionary(field, empty: [[String: Any]]())
  }

  private static func getArrayOfDictionary(_ field: String, empty: [[String: Any]]) -> [[String: Any]] {
    if let arrayOfDict = shared.dictionary[field] as? [[String: Any]] {
      return arrayOfDict
    }
    return empty
  }
}

// MARK: - General Methods
extension TargetUtils {

}

// MARK: - Color Methods
extension TargetUtils {
  static func getButtonColor() -> String {
    return targetPlistColors.buttonBaseColor
  }

  static func getPrimaryColor() -> String {
    return targetPlistColors.primaryColor
  }

  static func getLightColor() -> String {
    return targetPlistColors.lightColor
  }
}

// MARK: - String Methods
extension TargetUtils {
  static func getHomeDescription() -> String {
    return targetPlistString.homeDescriptionText
  }
}
