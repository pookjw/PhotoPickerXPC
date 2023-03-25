import Foundation

@objc public protocol PhotoPickerAppProtocol: NSObjectProtocol {
    func selectedLocalIdentifiers(_ localIdentifiers: [String]) async
    func errorOccured(error: Error)
}
