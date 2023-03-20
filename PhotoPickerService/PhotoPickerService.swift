//
//  PhotoPickerService.swift
//  PhotoPickerService
//
//  Created by Jinwoo Kim on 3/18/23.
//

import Foundation
import ExtensionFoundation

/// The AppExtensionConfiguration that will be provided by this extension.
/// This is typically defined by the extension host in a framework.
struct ExampleConfiguration<E:PhotoPickerServiceExtension>: AppExtensionConfiguration {
    
    let appExtension: E
    
    init(_ appExtension: E) {
        self.appExtension = appExtension
    }
    
    /// Determine whether to accept the XPC connection from the host.
    func accept(connection: NSXPCConnection) -> Bool {
        // TODO: Configure the XPC connection and return true
        connection.activate()
        return true
    }
}

/// The AppExtension protocol to which this extension will conform.
/// This is typically defined by the extension host in a framework.
public protocol PhotoPickerServiceExtension : AppExtension {
    func transform(_ input: String) async -> String?
}

extension PhotoPickerServiceExtension {
    var configuration: ExampleConfiguration<some PhotoPickerServiceExtension> {
        // Return your extension's configuration upon request.
        return ExampleConfiguration(self)
    }
}

@main
struct PhotoPickerService: PhotoPickerServiceExtension {
    var configuration: ExampleConfiguration<PhotoPickerService> { ExampleConfiguration(self) }
    
    func transform(_ input: String) async -> String? {
        input.uppercased()
    }
    
    init() { }
}