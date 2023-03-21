import Foundation

@objc public protocol PhotoPickerXPCProtocol: NSObjectProtocol {
    func transform(_ input: String) async
}
