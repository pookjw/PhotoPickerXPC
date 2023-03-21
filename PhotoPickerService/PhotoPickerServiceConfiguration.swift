//
//  PhotoPickerServiceConfiguration.swift
//  PhotoPickerService
//
//  Created by Jinwoo Kim on 3/22/23.
//

import Foundation
import ExtensionFoundation
import PhotoPickerCommon

actor PhotoPickerServiceConfiguration<E: PhotoPickerXPCExtension>: AppExtensionConfiguration {
    private let appExtension: E
    private let serviceObject: any PhotoPickerServiceProtocol
    private var connection: NSXPCConnection?
    
    init(_ appExtension: E) {
        self.appExtension = appExtension
        self.serviceObject = PhotoPickerServiceObject(appExtension: appExtension)
    }
    
    nonisolated func accept(connection: NSXPCConnection) -> Bool {
        connection.exportedInterface = .init(with: PhotoPickerServiceProtocol.self)
        connection.exportedObject = serviceObject
        
        connection.remoteObjectInterface = .init(with: PhotoPickerAppProtocol.self)
        
        Task {
            await self.connection?.invalidate()
            await self.setConnection(connection)
            connection.activate()
        }
        
        return true
    }
    
    func sendSelectedLocalIdentifiers(_ localIdentifiers: [String]) async throws {
        guard let remoteObject: any PhotoPickerAppProtocol = try await connection?._remoteObject() else {
            return
        }
        
        await remoteObject.selectedLocalIdentifiers(localIdentifiers)
    }
    
    private func setConnection(_ connection: NSXPCConnection?) {
        self.connection = connection
    }
}
