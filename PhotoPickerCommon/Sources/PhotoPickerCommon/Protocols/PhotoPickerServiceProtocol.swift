import Foundation

@objc public protocol PhotoPickerServiceProtocol: NSObjectProtocol {
    func transform(_ input: String) async -> String
}
