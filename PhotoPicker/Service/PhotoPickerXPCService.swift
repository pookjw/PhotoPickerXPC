//
//  PhotoPickerXPCService.swift
//  PhotoPicker
//
//  Created by Jinwoo Kim on 3/21/23.
//

import Foundation
import PhotoPickerCommon
import ExtensionFoundation

actor PhotoPickerXPCService: NSObject, PhotoPickerAppProtocol {
    private let process: AppExtensionProcess
    private let connection: NSXPCConnection
    
    init(process: AppExtensionProcess) throws {
        let connection: NSXPCConnection = try process.makeXPCConnection()
        
        self.process = process
        self.connection = connection
        
        super.init()
        
        connection.exportedInterface = .init(with: PhotoPickerAppProtocol.self)
        connection.exportedObject = self
        
        connection.remoteObjectInterface = .init(with: PhotoPickerServiceProtocol.self)
        connection.activate()
    }
    
    func transform(_ input: String) async throws -> String {
        let remoteObject: any PhotoPickerServiceProtocol = try await connection._remoteObject()
        return await remoteObject.transform(input)
    }
    
    func selectedLocalIdentifiers(_ localIdentifiers: [String]) async {
        print(localIdentifiers)
    }
    
    nonisolated func errorOccured(error: Error) {
        fatalError("\(error as NSError)")
    }
}
