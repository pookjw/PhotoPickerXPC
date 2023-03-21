import Foundation

@objc public protocol PhotoPickerAppProtocol: NSObjectProtocol {
    func selectedLocalIdentifiers(_ localIdentifiers: [String]) async
}
